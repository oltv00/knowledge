//
//  OLTVUsersTableViewController.m
//  iOSDev4501_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 04/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVUsersTableViewController.h"

//API
#import "../API/OLTVAPIServerManager.h"

//Model
#import "../Model/OLTVUser.h"

//Libs
#import "../Libs/UIKit+AFNetworking/UIImageView+AFNetworking.h"

//Controllers
#import "OLTVDetailedUserTableViewController.h"

//Categories
#import "../Categories/UIViewController+HideBackBarButtonItem.h"

@interface OLTVUsersTableViewController ()
@property (strong, nonatomic) NSMutableArray *friends;
@end

@implementation OLTVUsersTableViewController

#pragma mark - View lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setup];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Private methods

- (void)setup {
  self.friends = [NSMutableArray array];
  [self hideBackBarButtonItem];
  [self getFriendsFromServer];
}

#pragma mark - API

- (void)getFriendsFromServer {
  [[OLTVAPIServerManager sharedManager]
   getFriendsWithOffset:[self.friends count]
   count:10
   onSuccess:^(NSArray *friends) {
     [self.friends addObjectsFromArray:friends];
     
     if (friends > 0) {
       NSMutableArray *newPaths = [NSMutableArray array];
       for (int i = (int)[self.friends count] - (int)[friends count]; i < [self.friends count]; i += 1) {
         NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
         [newPaths addObject:indexPath];
       }
       
       [self.tableView beginUpdates];
       [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationFade];
       [self.tableView endUpdates];
     }
   }
   onFailure:^(NSError *error) {
     NSLog(@"error = %@", [error localizedDescription]);
   }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.friends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  
  OLTVUser *user = self.friends[indexPath.row];
  
  cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
  cell.imageView.image = nil;
  
  __weak UITableViewCell *weakCell = cell;
  NSURLRequest *urlRequest = [NSURLRequest requestWithURL:user.imageURL];
  [cell.imageView
   setImageWithURLRequest:urlRequest
   placeholderImage:nil
   success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
     weakCell.imageView.image = image;
     weakCell.imageView.layer.cornerRadius = image.size.height / 2;
     [weakCell layoutSubviews];
   }
   failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
     NSLog(@"error = %@", [error localizedDescription]);
   }];
    
  return cell;
  
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  OLTVUser *user = self.friends[indexPath.row];
  [self performSegueWithIdentifier:@"detailedUser" sender:user];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == [self.friends count] - 5) {
    [self getFriendsFromServer];
  }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.destinationViewController isKindOfClass:[OLTVDetailedUserTableViewController class]]) {
    OLTVDetailedUserTableViewController *vc = segue.destinationViewController;
    OLTVUser *user = sender;
    vc.userID = user.userID;
  }
}

@end
