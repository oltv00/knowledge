//
//  OLTVDetailedVideoViewController.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 13/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVDetailedVideoViewController.h"

//Consts
static NSString *const commentCellIdentifier = @"commentCell";
static NSString *const videoCellIdentifier = @"videoCell";

static NSInteger requestCount = 5;

//UI
#import "../Cells/OLTVDetailedVideoTableViewCell.h"
#import "../Cells/OLTVCommentTableViewCell.h"

//Model
#import "../Model/OLTVVideo.h"
#import "../Model/OLTVComment.h"
#import "../Model/OLTVUser.h"

//API
#import "../API/OLTVAPIManager.h"

//Libs
#import "../Libs/UIKit+AFNetworking/UIImageView+AFNetworking.h"

@interface OLTVDetailedVideoViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *comments;
@property (assign, nonatomic) BOOL loadingData;
@end

@implementation OLTVDetailedVideoViewController

#pragma mark - View lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];

  //Setup
  [self setupProperties];
  
  //API
  [self getVideoComments];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Setups

- (void)setupProperties {
  self.navigationItem.title = @"Video";
  self.comments = [NSMutableArray array];
  [self.comments addObject:self.video];
  self.loadingData = NO;
}

#pragma mark - API

- (void)getVideoComments {
  if (!self.loadingData) {
    self.loadingData = YES;
    [[OLTVAPIManager sharedManager]
     getVideoCommentsWithOwnerID:self.video.ownerID
     videoID:self.video.videoID
     offset:self.comments.count
     count:requestCount
     success:^(NSArray *comments) {
       if (comments.count >= 1) {
         
         [self.comments addObjectsFromArray:comments];
         [self.tableView reloadData];
         self.loadingData = NO;
         
       } else {
         
         //timeout 2 sec to get new api request
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           self.loadingData = NO;
         });
       }
     }
     failure:^(NSError *error) {
       NSLog(@"%@ getVideoCommentsWithOwnerID error = %@", [self class], [error localizedDescription]);
     }];
  }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.row == 0) {
    
    OLTVDetailedVideoTableViewCell *videoCell = [tableView dequeueReusableCellWithIdentifier:videoCellIdentifier];
    OLTVVideo *video = self.video;
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:video.videoURL];
    [videoCell.videoWebView loadRequest:urlRequest];
    
    videoCell.likesCountLabel.text = video.likes;
    videoCell.commentsCountLabel.text = video.comments;
    videoCell.titleLabel.text = video.title;
    videoCell.viewsLabel.text = video.views;
    videoCell.durationLabel.text = video.duration;
    videoCell.descriptionLabel.text = video.descrip;
    
    return videoCell;
  
  } else {
    
    OLTVCommentTableViewCell *commentCell = [tableView dequeueReusableCellWithIdentifier:commentCellIdentifier];
    OLTVComment *comment = self.comments[indexPath.row];
    
    commentCell.dateLabel.text = [comment stringFromDate:comment.date];
    commentCell.fullNameLabel.text = [NSString stringWithFormat:@"%@ %@", comment.user.first_name, comment.user.last_name];
    commentCell.commentTextLabel.text = comment.text;
    commentCell.userAvatar.layer.cornerRadius = CGRectGetHeight(commentCell.userAvatar.frame)/2;
    
    UIImage *placeholder = [UIImage imageNamed:@"userAvatarPlaceholder"];
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:comment.user.photoURL];
    [commentCell.userAvatar
     setImageWithURLRequest:imageRequest
     placeholderImage:placeholder
     success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
       commentCell.userAvatar.image = image;
       [commentCell.userAvatar layoutSubviews];
     }
     failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
       NSLog(@"setImageWithURLRequest error = %@", [error localizedDescription]);
     }];
    
    if (!comment.user) {
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [tableView reloadData];
      });
    }
    
    return commentCell;
  }  
  return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.row == 0) {
    
    
    CGFloat webView = 200.f;
    CGFloat title = 21.f;
    CGFloat views = 16.f;
    CGFloat description = [OLTVDetailedVideoTableViewCell heightForText:self.video.descrip];
    CGFloat button = 20.f;
    
    CGFloat result = webView + title + views + description + button	;
    return result;
    
  } else {
    
    OLTVComment *comment = self.comments[indexPath.row];
    
    CGFloat textHeight = [OLTVCommentTableViewCell heightForText:comment.text];
    CGFloat userPhotoHeight = 50.f;
    CGFloat offset = 8.f;
    
    CGFloat result = textHeight + userPhotoHeight + offset*2;
    return result;
  }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
  CGFloat offset = scrollView.contentOffset.y;
  CGFloat frameHeight = scrollView.frame.size.height;
  CGFloat contentHeight = scrollView.contentSize.height;

  if ((offset + frameHeight) >= contentHeight - frameHeight * 2) {
    if (!self.loadingData) {
      [self getVideoComments];
    }
  }
}
@end




























