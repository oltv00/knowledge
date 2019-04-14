//
//  OLTVFollowersTableViewController.m
//  iOSDev4501_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 06/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVFollowersTableViewController.h"

//API
#import "../API/OLTVAPIServerManager.h"

//Model
#import "../Model/OLTVUser.h"

//Libs
#import "../Libs/UIKit+AFNetworking/UIImageView+AFNetworking.h"

//Categories
#import "../Categories/UIViewController+HideBackBarButtonItem.h"

@interface OLTVFollowersTableViewController ()
@property (strong, nonatomic) NSMutableArray <OLTVUser*> *followers;
@end

@implementation OLTVFollowersTableViewController

#pragma mark - View lifecycles
- (void)viewDidLoad {
  [super viewDidLoad];
  [self hideBackBarButtonItem];
  self.followers = [NSMutableArray array];
  [self getFollowersFromServer];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - API

- (void)getFollowersFromServer {
  [[OLTVAPIServerManager sharedManager]
   getFollowersWithUserID:self.userID
   offset:[self.followers count]
   count:10
   onSuccess:^(NSArray *users) {
     [self.followers addObjectsFromArray:users];
     [self.tableView reloadData];
   }
   onFailure:^(NSError *error) {
     NSLog(@"error = %@", [error localizedDescription]);
   }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.followers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  
  OLTVUser *user = self.followers[indexPath.row];
  
  cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
  cell.imageView.image = nil;
  
  __weak UITableViewCell *weakCell = cell;
  NSURLRequest *urlRequest = [NSURLRequest requestWithURL:user.imageURL];
  [cell.imageView
   setImageWithURLRequest:urlRequest
   placeholderImage:nil
   success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
     weakCell.imageView.image = image;
     [weakCell layoutSubviews];
   }
   failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
     NSLog(@"error = %@", [error localizedDescription]);
   }];
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == [self.followers count] - 5) {
    [self getFollowersFromServer];
  }
}

@end
