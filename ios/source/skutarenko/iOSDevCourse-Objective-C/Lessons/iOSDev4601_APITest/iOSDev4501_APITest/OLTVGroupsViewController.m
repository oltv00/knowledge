//
//  OLTVGroupsViewController.m
//  iOSDev4501_APITest
//
//  Created by Oleg Tverdokhleb on 16/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVGroupsViewController.h"

#import "OLTVServerManager.h"
#import "OLTVPost.h"
#import "OLTVPostViewCell.h"

@interface OLTVGroupsViewController ()
@property (strong, nonatomic) NSMutableArray *posts;
@property (assign, nonatomic) BOOL loadingData;
@end

@implementation OLTVGroupsViewController

#pragma mark - View lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  self.posts = [NSMutableArray array];
  self.loadingData = NO;
  
  UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
  [refresh addTarget:self action:@selector(actionRefresh) forControlEvents:UIControlEventValueChanged];
  self.refreshControl = refresh;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  
}

#pragma mark - Actions

- (void)actionRefresh {
  if (!self.loadingData) {
    self.loadingData = YES;
    
    NSLog(@"getPostsFromServer");
    
    [[OLTVServerManager sharedManager]
     getGroupWallWithGroupID:@"58860049"
     offset:0
     count:MAX(5, self.posts.count)
     success:^(NSArray *posts) {
       
       [self.posts removeAllObjects];
       [self.posts addObjectsFromArray:posts];
       [self.tableView reloadData];
       [self.refreshControl endRefreshing];
       self.loadingData = NO;
       
     }
     
     failure:^(NSError *error) {
       NSLog(@"error = %@", [error localizedDescription]);
       [self.refreshControl endRefreshing];
     }];
  }
}

#pragma mark - API

- (void)getPostsFromServer {
  if (!self.loadingData) {
    self.loadingData = YES;
    
    NSLog(@"getPostsFromServer");
    
    [[OLTVServerManager sharedManager]
     getGroupWallWithGroupID:@"58860049"
     offset:[self.posts count]
     count:5
     success:^(NSArray *posts) {
       
       [self.posts addObjectsFromArray:posts];
       
       [self.tableView reloadData];
       self.loadingData = NO;
     }
     
     failure:^(NSError *error) {
       NSLog(@"error = %@", [error localizedDescription]);
     }];
  }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *identifier = @"postCell";
  OLTVPostViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  
  OLTVPost *post = self.posts[indexPath.row];
  cell.postLabel.text = post.text;
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  OLTVPost *post = self.posts[indexPath.row];
  CGFloat height = [OLTVPostViewCell heightForText:post.text];
  return height;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
  CGFloat offset = scrollView.contentOffset.y;
  CGFloat frameHeight = scrollView.frame.size.height;
  CGFloat contentHeight = scrollView.contentSize.height;
  
  if ((offset + frameHeight) >= contentHeight - frameHeight / 2) {
    if (!self.loadingData) {
      [self getPostsFromServer];
    }
  }
}

@end
