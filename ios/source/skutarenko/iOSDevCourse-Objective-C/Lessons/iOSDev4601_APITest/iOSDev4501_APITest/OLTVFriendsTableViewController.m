//
//  OLTVFriendsTableViewController.m
//  iOSDev4501_APITest
//
//  Created by Oleg Tverdokhleb on 02/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVFriendsTableViewController.h"

//API
#import "OLTVServerManager.h"

//Libs
#import "UIImageView+AFNetworking.h"
#import "UIImage+AFNetworking.h"

//Model
#import "OLTVUser.h"

@interface OLTVFriendsTableViewController ()
@property (strong, nonatomic) NSMutableArray *friendsArray;
@end

@implementation OLTVFriendsTableViewController

static NSInteger friendsInRequest = 5;

- (void)viewDidLoad {
  [super viewDidLoad];
  self.friendsArray = [NSMutableArray array];
  
  [[OLTVServerManager sharedManager] authorizeUser:^(OLTVUser *user) {
    NSLog(@"authorizeUser completion");
  }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - API

- (void)getFriendsFromServer {
  [[OLTVServerManager sharedManager]
   getFriendsWithOffset:[self.friendsArray count]
   count:friendsInRequest
   onSuccess:^(NSArray *friends) {
     [self.friendsArray addObjectsFromArray:friends];
     
     NSMutableArray *newPaths = [NSMutableArray array];
     for (int index = (int)[self.friendsArray count] - (int)[friends count]; index < [self.friendsArray count]; index += 1) {
       [newPaths addObject:[NSIndexPath indexPathForRow:index inSection:0]];
     }
     
     [self.tableView beginUpdates];
     [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationFade];
     [self.tableView endUpdates];
   }
   onFailure:^(NSError *error, NSInteger statusCode) {
     NSLog(@"error = %@, code = %ld", [error localizedDescription], statusCode);
   }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.friendsArray count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *callIdentifier = @"cellIdentifier";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:callIdentifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:callIdentifier];
  }
  
  if (indexPath.row == [self.friendsArray count]) {
    
    cell.textLabel.text = @"LOAD MORE";
    cell.imageView.image = nil;
    
  } else {
    
    OLTVUser *user = self.friendsArray[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    cell.imageView.image = nil;
    
    __weak UITableViewCell *weakCell = cell;
    NSURLRequest *request = [NSURLRequest requestWithURL:user.imageURL];
    [cell.imageView
     setImageWithURLRequest:request
     placeholderImage:nil
     success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
       weakCell.imageView.image = image;
       [weakCell layoutSubviews];
     }
     failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
       NSLog(@"error = %@", [error localizedDescription]);
     }];

  }
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  if (indexPath.row == [self.friendsArray count]) {
    [self getFriendsFromServer];
  }
}

@end
