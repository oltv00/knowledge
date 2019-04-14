//
//  OLTVDetailedPostViewController.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 29/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVDetailedPostViewController.h"

typedef NS_ENUM(NSInteger, OLTVKeyboardStatus) {
  OLTVKeyboardStatusShow = 1,
  OLTVKeyboardStatusHide = 2
};

//Consts
static NSString *const wallCellIdentifier = @"wallCell";

static NSString *const commentCellIdentifier = @"commentCell";

static NSInteger const requestCount = 5;

//UI
#import "../Cells/OLTVPostTableViewCell.h"
#import "../Cells/OLTVCommentTableViewCell.h"

//API
#import "../API/OLTVAPIManager.h"

//Model
#import "../Model/OLTVPost.h"
#import "../Model/OLTVComment.h"
#import "../Model/OLTVUser.h"

//Libs
#import "../Libs/UIKit+AFNetworking/UIImageView+AFNetworking.h"

@interface OLTVDetailedPostViewController ()

@property (strong, nonatomic) NSMutableArray *comments;
@property (assign, nonatomic) BOOL loadingData;
@property (assign, nonatomic) OLTVKeyboardStatus keyboardStatus;

@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendCommentButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentTextFieldBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendCommentButtonConstraint;

- (IBAction)actionPostComment:(UIButton *)sender;
- (IBAction)actionLikeButton:(UIButton *)sender;

@end

@implementation OLTVDetailedPostViewController

#pragma mark - View lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //Setups
  [self setupProperties];
  [self setupNotifications];
  [self setupGestures];
  
  //API
  [self getCommentsFromServer];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Setups

- (void)setupProperties {
  self.comments = [NSMutableArray array];
  [self.comments addObject:self.wall];
  self.loadingData = NO;
  self.keyboardStatus = OLTVKeyboardStatusHide;
}

- (void)setupNotifications {
  
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(keyboardWillShowNotification:)
   name:UIKeyboardWillShowNotification
   object:nil];
  
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(keyboardWillHideNotification:)
   name:UIKeyboardWillHideNotification
   object:nil];
}

- (void)setupTableViewOffset {
  if (self.tableView.contentSize.height > self.tableView.frame.size.height) {
    CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
    [self.tableView setContentOffset:offset animated:YES];
  }
}

- (void)setupGestures {
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(handleTapGesture:)];
  [self.view addGestureRecognizer:tapGesture];
}

#pragma mark - API

- (void)getCommentsFromServer {
  
  if (!self.loadingData) {
    self.loadingData = YES;
    
    [[OLTVAPIManager sharedManager]
     getWallPostCommentsWithOwnerID:self.wall.owner_id
     postID:self.wall.post_id
     offset:self.comments.count - 1
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
       NSLog(@"%@", [error localizedDescription]);
       self.loadingData = NO;
     }];
  }
}

#pragma mark - Private methods

- (void)changeViewsPositionWithNotification:(NSNotification *)notification {
  NSDictionary *userInfo = notification.userInfo;
  NSValue *value = userInfo[@"UIKeyboardFrameEndUserInfoKey"];
  CGRect newRect = [value CGRectValue];
  CGFloat offset = 8.f;
  CGFloat constraint = 0.f;
  if (self.keyboardStatus == OLTVKeyboardStatusShow) {
    constraint = CGRectGetHeight(newRect) + offset;
  } else if (self.keyboardStatus == OLTVKeyboardStatusHide) {
    constraint = offset;
  }
  [UIView animateWithDuration:0.25f
                        delay:0.f
                      options:UIViewAnimationOptionAllowAnimatedContent
                   animations:^{
                     self.commentTextFieldBottomConstraint.constant = constraint;
                     self.sendCommentButtonConstraint.constant = constraint;
                     [self.view layoutIfNeeded];
                   }
                   completion:^(BOOL finished) {
                     //NSLog(@"finished = %d", finished);
                   }];
}

#pragma mark - Handle

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
  NSLog(@"handleTapGesture");
  [self.view endEditing:YES];
}

#pragma mark - Actions

- (IBAction)actionPostComment:(UIButton *)sender {
  
  [[OLTVAPIManager sharedManager]
   postMessageToWallPostWithOwnerID:self.wall.owner_id
   postID:self.wall.post_id
   message:self.commentTextField.text
   completion:^(id response, NSError *error) {
     if (error) {
       NSLog(@"actionPostComment postMessageToWallPostWithOwnerID error = %@", [error localizedDescription]);
     } else {
       
       [self.commentTextField resignFirstResponder];
       self.commentTextField.text = @"";
       
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self getCommentsFromServer];
         [self setupTableViewOffset];
       });
     }
   }];
}

- (IBAction)actionLikeButton:(UIButton *)sender {
  
  [[OLTVAPIManager sharedManager]
   postLikeToType:@"post"
   ownerID:self.wall.owner_id
   itemID:self.wall.post_id
   completion:^(NSDictionary *response, NSError *error) {
     if (error) {
       NSLog(@"actionLikeButton error = %@", [error localizedDescription]);
     } else {
       
       self.wall.likesCount = response[@"likes"];
       [self.tableView reloadData];
       
     }
   }];
}

#pragma mark - Notifications

- (void)keyboardWillShowNotification:(NSNotification *)notification {
  NSLog(@"keyboardWillShowNotification");
  
  if (self.keyboardStatus == OLTVKeyboardStatusHide) {
    self.keyboardStatus = OLTVKeyboardStatusShow;
    [self changeViewsPositionWithNotification:notification];
    [self setupTableViewOffset];
  }
}

- (void)keyboardWillHideNotification:(NSNotification *)notification {
  NSLog(@"keyboardWillHideNotification");
  
  if (self.keyboardStatus == OLTVKeyboardStatusShow) {
    self.keyboardStatus = OLTVKeyboardStatusHide;
    [self changeViewsPositionWithNotification:notification];
    [self setupTableViewOffset];
  }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.row == 0) {
    
    OLTVPostTableViewCell *wallCell = [tableView dequeueReusableCellWithIdentifier:wallCellIdentifier];
    
    OLTVPost *wall = self.wall;
    wallCell.wallTextLabel.text = wall.text;
    wallCell.likesCountLabel.text = [wall.likesCount stringValue];
    wallCell.commentsCountLabel.text = [wall.commentsCount stringValue];
    wallCell.dateLabel.text = [wall stringFromDate:wall.date];
    wallCell.fullNameLabel.text = [NSString stringWithFormat:@"%@ %@", wall.user.first_name, wall.user.last_name];
    wallCell.userAvatar.layer.cornerRadius = CGRectGetHeight(wallCell.userAvatar.frame)/2;
    
    UIImage *placeholder = [UIImage imageNamed:@"userAvatarPlaceholder"];
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:wall.user.photoURL];
    [wallCell.userAvatar
     setImageWithURLRequest:imageRequest
     placeholderImage:placeholder
     success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
       wallCell.userAvatar.image = image;
       [wallCell.userAvatar layoutSubviews];
     }
     failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
       NSLog(@"setImageWithURLRequest error = %@", [error localizedDescription]);
     }];
    
    if (!wall.user) {
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [tableView reloadData];
      });
    }
    
    return wallCell;
    
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
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.row == 0) {
    
    OLTVPost *wall = self.wall;
    
    CGFloat textHeight = [OLTVPostTableViewCell heightForText:wall.text];
    CGFloat bottomImageHeight = 20.f;
    CGFloat userPhotoHeight = 50.f;
    CGFloat offset = 8.f;
    
    CGFloat result = textHeight + bottomImageHeight + userPhotoHeight + offset*2;
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
  
  //NSLog(@"scrollView.contentOffset.y = %f", scrollView.contentOffset.y);
  //NSLog(@"scrollView.frame.size.height = %f", scrollView.frame.size.height);
  //NSLog(@"scrollView.contentSize.height = %f", scrollView.contentSize.height);
  
  if ((offset + frameHeight) >= contentHeight - frameHeight * 2) {
    if (!self.loadingData) {
      [self getCommentsFromServer];
    }
  }
}

@end
