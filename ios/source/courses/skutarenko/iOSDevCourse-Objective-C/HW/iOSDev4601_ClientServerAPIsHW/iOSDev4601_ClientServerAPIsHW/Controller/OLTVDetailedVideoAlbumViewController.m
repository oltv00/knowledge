//
//  OLTVDetailedVideoAlbumViewController.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 13/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVDetailedVideoAlbumViewController.h"

//Model
#import "../Model/OLTVVideoAlbum.h"
#import "../Model/OLTVVideo.h"

//API
#import "OLTVAPIManager.h"

//Consts
static NSString *const videoCellIdentifier = @"videoCell";

static NSString *const showDetailedVideoSegue = @"showDetailedVideo";

//UI
#import "../Cells/OLTVVideoTableViewCell.h"

//Libs
#import "UIImageView+AFNetworking.h"

//Controller
#import "../Controller/OLTVDetailedVideoViewController.h"

@interface OLTVDetailedVideoAlbumViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *videos;
@property (assign, nonatomic) BOOL loadingData;
@end

@implementation OLTVDetailedVideoAlbumViewController

#pragma mark - View lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //Setups
  [self setupProperties];
  
  //API
  [self getVideosFromServer];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Setups

- (void)setupProperties {
  self.videos = [NSMutableArray array];
  self.loadingData = NO;
  self.navigationItem.title = self.album.title;
}

#pragma mark - API

- (void)getVideosFromServer {
  if (!self.loadingData) {
    self.loadingData = YES;
    NSInteger requestCount = self.videos.count <= 10 ? 10 : 5;
    
    [[OLTVAPIManager sharedManager]
     getVideosWithOwnerID:self.album.ownerID
     albumID:self.album.albumID
     offset:self.videos.count
     count:requestCount
     completion:^(NSArray *videos, NSError *error) {
       if (error) {
         NSLog(@"getVideosWithOwnerID error = %@", [error localizedDescription]);
       } else {
         if (videos.count > 0) {
           [self.videos addObjectsFromArray:videos];
           self.loadingData = NO;
           [self.tableView reloadData];
         }
       }
     }];
  }
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:showDetailedVideoSegue]) {
    if ([sender isKindOfClass:[OLTVVideo class]]) {
      OLTVDetailedVideoViewController *vc = segue.destinationViewController;
      OLTVVideo *video = sender;
      vc.video = video;
    }
  }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  OLTVVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:videoCellIdentifier];
  OLTVVideo *video = self.videos[indexPath.row];
  
  cell.videoTitleLabel.text = video.title;
  cell.albumTitleLabel.text = self.album.title;
  cell.viewsCountLabel.text = [NSString stringWithFormat:@"%@ views", video.views];
  cell.durationLabel.text = video.duration;
  
  NSURLRequest *request = [NSURLRequest requestWithURL:video.photoURL];
  UIImage *placeholder = [UIImage imageNamed:@"userAvatarPlaceholder"];
  [cell.previewImageView
   setImageWithURLRequest:request
   placeholderImage:placeholder
   success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
     cell.previewImageView.image = image;
     [cell.previewImageView layoutSubviews];
   }
   failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
     NSLog(@"%@ setImageWithURLRequest error = %@", [self class], [error localizedDescription]);
   }];
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 88.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  OLTVVideo *video = self.videos[indexPath.row];
  [self performSegueWithIdentifier:showDetailedVideoSegue sender:video];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
  CGFloat offset = scrollView.contentOffset.y;
  CGFloat frameHeight = scrollView.frame.size.height;
  CGFloat contentHeight = scrollView.contentSize.height;
  
  if ((offset + frameHeight) >= contentHeight - frameHeight * 2) {
    if (!self.loadingData) {
      [self getVideosFromServer];
    }
  }
}

@end
























