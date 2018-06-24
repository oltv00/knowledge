//
//  OLTVVideosViewController.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 11/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVVideoAlbumsViewController.h"

//API
#import "../API/OLTVAPIManager.h"

//Consts
static NSString *const videoAlbumCellIdentifier = @"videoAlbumCell";
static NSString *const showDetailedVideoAlbumSegue = @"showDetailedVideoAlbum";

//UI
#import "../Cells/OLTVVideoAlbumTableViewCell.h"

//Model
#import "../Model/OLTVVideoAlbum.h"

//Libs
#import "../Libs/UIKit+AFNetworking/UIImageView+AFNetworking.h"

//Controller
#import "../Controller/OLTVDetailedVideoAlbumViewController.h"

@interface OLTVVideoAlbumsViewController ()

@property (strong, nonatomic) NSMutableArray *videoAlbums;
@property (assign, nonatomic) BOOL loadingData;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OLTVVideoAlbumsViewController

#pragma mark - View lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //Setups
  [self setupProperties];
  
  //API
  [self getVideosAlbumsFromServer];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Setups

- (void)setupProperties {
  self.navigationItem.title = @"Albums";
  self.videoAlbums = [NSMutableArray array];
  self.loadingData = NO;
}

#pragma mark - API

- (void)getVideosAlbumsFromServer {
  if (!self.loadingData) {
    self.loadingData = YES;
    NSInteger requestCount = self.videoAlbums.count <= 10 ? 10 : 5;
    [[OLTVAPIManager sharedManager]
     getVideoAlbumsWithOwnerID:self.ownerID
     offset:self.videoAlbums.count
     count:requestCount
     completion:^(NSArray *albums, NSError *error) {
       if (error) {
         NSLog(@"%@ getVideosAlbumsFromServer error = %@", [self class], [error localizedDescription]);
         self.loadingData = NO;
       } else {
         
         if (albums.count > 0) {
           [self.videoAlbums addObjectsFromArray:albums];
           self.loadingData = NO;
           [self.tableView reloadData];
         }
       }
     }];
  }
}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:showDetailedVideoAlbumSegue]) {
    if ([sender isKindOfClass:[OLTVVideoAlbum class]]) {
      OLTVDetailedVideoAlbumViewController *vc = segue.destinationViewController;
      OLTVVideoAlbum *album = sender;
      vc.album = album;
    }
  }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.videoAlbums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  OLTVVideoAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:videoAlbumCellIdentifier];
  OLTVVideoAlbum *album = self.videoAlbums[indexPath.row];
  
  cell.titleLabel.text = album.title;
  cell.countLabel.text = [NSString stringWithFormat:@"%@ videos", album.count];
  
  NSURLRequest *request = [NSURLRequest requestWithURL:album.photoURL];
  UIImage *placeholder = [UIImage imageNamed:@"userAvatarPlaceholder"];
  [cell.photoImageView
   setImageWithURLRequest:request
   placeholderImage:placeholder
   success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
     cell.photoImageView.image = image;
     [cell.photoImageView layoutSubviews];
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
  OLTVVideoAlbum *album = self.videoAlbums[indexPath.row];
  [self performSegueWithIdentifier:showDetailedVideoAlbumSegue sender:album];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
  CGFloat offset = scrollView.contentOffset.y;
  CGFloat frameHeight = scrollView.frame.size.height;
  CGFloat contentHeight = scrollView.contentSize.height;
  
  if ((offset + frameHeight) >= contentHeight - frameHeight * 2) {
    if (!self.loadingData) {
      [self getVideosAlbumsFromServer];
    }
  }
}

@end

































