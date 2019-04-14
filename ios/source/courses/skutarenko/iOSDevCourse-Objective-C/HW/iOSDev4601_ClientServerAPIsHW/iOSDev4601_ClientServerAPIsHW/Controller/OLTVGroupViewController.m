//
//  OLTVGroupViewController.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 19/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVGroupViewController.h"

//API
#import "../API/OLTVAPIManager.h"

//Model
#import "../Model/OLTVUser.h"
#import "../Model/OLTVPost.h"
#import "../Model/OLTVGroup.h"

//Consts
static NSInteger const requestCount = 10;

static NSString *const postCellIdentifier = @"postCell";
static NSString *const groupCellIdentifier = @"groupCell";
static NSString *const groupMenuCellIdentifier = @"groupMenuCell";

static NSString *const postMessageSegue = @"postMessage";
static NSString *const sendMessageSegue = @"sendMessage";
static NSString *const showDetailedPostSegue = @"showDetailedPost";
static NSString *const showPhotosSegue = @"showPhotos";
static NSString *const showVideosSegue = @"showVideos";

//UI
#import "../Cells/OLTVPostTableViewCell.h"
#import "../Cells/OLTVGroupTableViewCell.h"
#import "../Cells/OLTVGroupMenuCollectionViewCell.h"

//Controller
#import "../Controller/OLTVPostMessageViewController.h"
#import "../Controller/OLTVMessagesViewController.h"
#import "../Controller/OLTVDetailedPostViewController.h"
#import "../Controller/OLTVPhotosViewController.h"
#import "../Controller/OLTVVideoAlbumsViewController.h"

//Libs
#import "../Libs/UIKit+AFNetworking/UIImageView+AFNetworking.h"

//Categories
#import "../Categories/UIView+UITableViewCell.h"
#import "../Categories/UIViewController+HideBackBarButtonItem.h"

@interface OLTVGroupViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (assign, nonatomic, getter=isFirstTimeAppear) BOOL firstTimeAppear;

@property (strong, nonatomic) NSMutableArray *wallPosts;
@property (assign, nonatomic) BOOL loadingData;

@property (strong, nonatomic) OLTVGroup *group;

- (IBAction)actionSendMessage:(UIButton *)sender;
- (IBAction)actionLikeButton:(UIButton *)sender;

@end

@implementation OLTVGroupViewController

#pragma mark - View lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //Setups
  [self setupProperties];
  [self hideBackBarButtonItem];
  [self setupWallRefresh];
  
  //API
  [self getGroupHeader];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if (self.isFirstTimeAppear) {
    self.firstTimeAppear = NO;
    [self userAuthorize];
  }
}

#pragma mark - Setups

- (void)setupProperties {
  self.firstTimeAppear = YES;
  self.navigationItem.title = @"iOS Dev Course";
  self.loadingData = NO;
  self.wallPosts = [NSMutableArray array];
}

- (void)setupWallRefresh {
  UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
  [refreshControl addTarget:self action:@selector(refreshWall) forControlEvents:UIControlEventValueChanged];
  self.refreshControl = refreshControl;
}

#pragma mark - API

- (void)userAuthorize {
  [[OLTVAPIManager sharedManager] authorizeUser:^(OLTVUser *user) {
    NSLog(@"authorizeUser");
    NSLog(@"%@ %@", user.first_name, user.last_name);
    [self.tableView reloadData];
  } failure:^(NSError *error) {
    NSLog(@"authorizeUser error = %@", error);
  }];
}

- (void)getGroupHeader {
  if (!self.loadingData) {
    self.loadingData = YES;
    [[OLTVAPIManager sharedManager]
     getGroupByID:@"58860049"
     completion:^(OLTVGroup *group, NSError *error) {
       
       if (error) {
         NSLog(@"getGroupHeader error = %@", [error localizedDescription]);
         self.loadingData = NO;
      
       } else {
         
         if (group) {
           self.group = group;
           self.loadingData = NO;
           [self.tableView reloadData];
           [self getGroupWall];
         }
       }
     }];
  }
}

- (void)getGroupWall {
  if (!self.loadingData) {
    self.loadingData = YES;
    [[OLTVAPIManager sharedManager]
     getGroupWallWithOwnerID:@"58860049"
     offset:[self.wallPosts count]
     count:requestCount
     success:^(NSArray *wallPosts) {
       
       [self.wallPosts addObjectsFromArray:wallPosts];
       self.loadingData = NO;
       [self.tableView reloadData];
       
     }
     failure:^(NSError *error) {
       NSLog(@"getGroupWall error = %@", [error localizedDescription]);
       self.loadingData = NO;
     }];
  }
}

#pragma mark - Actions

- (void)refreshWall {
  if (!self.loadingData) {
    self.loadingData = YES;
    [[OLTVAPIManager sharedManager]
     getGroupWallWithOwnerID:@"58860049"
     offset:0
     count:requestCount
     success:^(NSArray *wallPosts) {
       
       [self.wallPosts removeAllObjects];
       [self.wallPosts addObjectsFromArray:wallPosts];
       self.loadingData = NO;
       [self.tableView reloadData];
       [self.refreshControl endRefreshing];
       
     }
     failure:^(NSError *error) {
       NSLog(@"refreshWall error = %@", [error localizedDescription]);
       [self.refreshControl endRefreshing];
       self.loadingData = NO;
     }];
  }
}

- (IBAction)actionSendMessage:(UIButton *)sender {
  UITableViewCell *cell = [sender superTableViewCell];
  NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
  OLTVPost *wall = self.wallPosts[indexPath.row];
  [self performSegueWithIdentifier:sendMessageSegue sender:wall.user];
}

- (IBAction)actionLikeButton:(UIButton *)sender {
  
  UITableViewCell *cell = [sender superTableViewCell];
  NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
  OLTVPost *wall = self.wallPosts[indexPath.row];
  
  [[OLTVAPIManager sharedManager]
   postLikeToType:@"post"
   ownerID:wall.owner_id
   itemID:wall.post_id
   completion:^(NSDictionary *response, NSError *error) {
     if (error) {
       NSLog(@"actionLikeButton error = %@", [error localizedDescription]);
     } else {
       
       wall.likesCount = response[@"likes"];
       [self.tableView reloadData];
     }
   }];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:postMessageSegue]) {
    OLTVPostMessageViewController *vc = segue.destinationViewController;
    vc.ownerID = @"-58860049";
  }
  
  if ([segue.identifier isEqualToString:sendMessageSegue]) {
    OLTVMessagesViewController *vc = segue.destinationViewController;
    if (sender && [sender isKindOfClass:[OLTVUser class]]) {
      OLTVUser *user = sender;
      vc.user = user;
    }
  }
  
  if ([segue.identifier isEqualToString:showDetailedPostSegue]) {
    OLTVDetailedPostViewController *vc = segue.destinationViewController;
    if (sender && [sender isKindOfClass:[OLTVPost class]]) {
      OLTVPost *wall = sender;
      vc.wall = wall;
    }
  }
  
  if ([segue.identifier isEqualToString:showPhotosSegue]) {
    OLTVPhotosViewController *vc = segue.destinationViewController;
    vc.ownerID = self.group.groupID;
  }
  
  if ([segue.identifier isEqualToString:showVideosSegue]) {
    OLTVVideoAlbumsViewController *vc = segue.destinationViewController;
    vc.ownerID = self.group.groupID;
  }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (!self.group && !self.loadingData) {
    [self getGroupHeader];
  }
  
  if (self.wallPosts.count > 0 && ![self.wallPosts[0] isKindOfClass:[OLTVGroup class]]) {
    [self.wallPosts insertObject:self.group atIndex:0];
  }
  
  return [self.wallPosts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.row == 0) {
    
    OLTVGroupTableViewCell *groupCell = [tableView dequeueReusableCellWithIdentifier:groupCellIdentifier];
    
    groupCell.nameLabel.text = self.group.name;
    groupCell.descripLabel.text = self.group.descrip;
    groupCell.siteLabel.text = self.group.site;
    groupCell.photoImageView.layer.cornerRadius = CGRectGetHeight(groupCell.photoImageView.frame)/2;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.group.photoURL];
    UIImage *placeholder = [UIImage imageNamed:@"userAvatarPlaceholder"];
    [groupCell.photoImageView
     setImageWithURLRequest:request
     placeholderImage:placeholder
     success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
       groupCell.photoImageView.image = image;
       [groupCell.photoImageView layoutSubviews];
     }
     failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
       NSLog(@"setImageWithURLRequest error = %@", [error localizedDescription]);
     }];
    
    return groupCell;
    
  } else {
    
    OLTVPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:postCellIdentifier];
    
    OLTVPost *wall = self.wallPosts[indexPath.row];
    cell.wallTextLabel.text = wall.text;
    cell.likesCountLabel.text = [wall.likesCount stringValue];
    cell.commentsCountLabel.text = [wall.commentsCount stringValue];
    cell.dateLabel.text = [wall stringFromDate:wall.date];
    cell.fullNameLabel.text = [NSString stringWithFormat:@"%@ %@", wall.user.first_name, wall.user.last_name];
    cell.userAvatar.layer.cornerRadius = CGRectGetHeight(cell.userAvatar.frame)/2;
    
    UIImage *placeholder = [UIImage imageNamed:@"userAvatarPlaceholder"];
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:wall.user.photoURL];
    [cell.userAvatar
     setImageWithURLRequest:imageRequest
     placeholderImage:placeholder
     success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
       cell.userAvatar.image = image;
       [cell.userAvatar layoutSubviews];
     }
     failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
       NSLog(@"setImageWithURLRequest error = %@", [error localizedDescription]);
     }];
    
    if (!wall.user) {
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [tableView reloadData];
      });
    }
    
    return cell;
  }
  return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.row == 0) {
    return 158.f;
  } else {
    
    OLTVPost *wall = self.wallPosts[indexPath.row];
    
    CGFloat textHeight = [OLTVPostTableViewCell heightForText:wall.text];
    CGFloat bottomImageHeight = 20.f;
    CGFloat userPhotoHeight = 50.f;
    CGFloat offset = 8.f;
    
    CGFloat result = textHeight + bottomImageHeight + userPhotoHeight + offset*2;
    
    return result;
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  if (indexPath.row != 0) {
    OLTVPost *wall = self.wallPosts[indexPath.row];
    [self performSegueWithIdentifier:showDetailedPostSegue sender:wall];
  }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
  CGFloat offset = scrollView.contentOffset.y;
  CGFloat frameHeight = scrollView.frame.size.height;
  CGFloat contentHeight = scrollView.contentSize.height;
  
  if ((offset + frameHeight) >= contentHeight - frameHeight * 2) {
    if (!self.loadingData && ![scrollView isKindOfClass:[UICollectionView class]]) {
      [self getGroupWall];
    }
  }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return [self.group.menu count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  OLTVGroupMenuCollectionViewCell *groupMenuCell = [collectionView dequeueReusableCellWithReuseIdentifier:groupMenuCellIdentifier forIndexPath:indexPath];
  
  OLTVGroupMenu *menu = self.group.menu[indexPath.row];
  
  groupMenuCell.titleLabel.text = menu.title;
  groupMenuCell.countLabel.text = menu.count;
  
  return groupMenuCell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  OLTVGroupMenu *menu = self.group.menu[indexPath.row];
  
  if ([menu.title isEqualToString:@"photos"]) {
    [self performSegueWithIdentifier:showPhotosSegue sender:nil];
  }
  
  if ([menu.title isEqualToString:@"videos"]) {
    [self performSegueWithIdentifier:showVideosSegue sender:nil];
  }
}

@end































