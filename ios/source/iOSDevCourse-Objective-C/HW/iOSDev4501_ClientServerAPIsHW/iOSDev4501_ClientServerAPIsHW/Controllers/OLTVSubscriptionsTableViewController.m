//
//  OLTVSubscriptionsTableViewController.m
//  iOSDev4501_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 04/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVSubscriptionsTableViewController.h"

typedef NS_ENUM(NSInteger, OLTVSubscriptions) {
  OLTVSubscriptionsUsers = 0,
  OLTVSubscriptionsGroups = 1
};

//API
#import "../API/OLTVAPIServerManager.h"

//Model
#import "../Model/OLTVUser.h"
#import "../Model/OLTVGroup.h"

//Libs
#import "../Libs/UIKit+AFNetworking/UIImageView+AFNetworking.h"

//Categories
#import "../Categories/UIViewController+HideBackBarButtonItem.h"

@interface OLTVSubscriptionsTableViewController ()

@property (strong, nonatomic) NSMutableArray *users;
@property (strong, nonatomic) NSMutableArray *groups;
@property (weak, nonatomic) IBOutlet UISegmentedControl *usersOrGroups;

- (IBAction)actionUsersOrGroups:(UISegmentedControl *)sender;

@end

@implementation OLTVSubscriptionsTableViewController

#pragma mark - View lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  [self hideBackBarButtonItem];
  
  self.users = [NSMutableArray array];
  self.groups = [NSMutableArray array];
  [self getSubscriptionsFromServer];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - API

- (void)getSubscriptionsFromServer {
  [[OLTVAPIServerManager sharedManager]
   getSubscriptionsWithUserID:self.userID
   offset:[self.users count] + [self.groups count]
   count:10
   onSuccess:^(NSArray *users, NSArray *groups) {
     
     [self.users addObjectsFromArray:users];
     [self.groups addObjectsFromArray:groups];
     [self.tableView reloadData];
     
   }
   onFailure:^(NSError *error) {
     NSLog(@"error = %@", [error localizedDescription]);
   }];
}

#pragma mark - Actions

- (IBAction)actionUsersOrGroups:(UISegmentedControl *)sender {
  if (self.usersOrGroups.selectedSegmentIndex == OLTVSubscriptionsUsers) {
    self.navigationItem.title = @"Users";
  } else if (self.usersOrGroups.selectedSegmentIndex == OLTVSubscriptionsGroups) {
    self.navigationItem.title = @"Groups";
  }
  [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.usersOrGroups.selectedSegmentIndex == OLTVSubscriptionsUsers) {
    return [self.users count];
  } else if (self.usersOrGroups.selectedSegmentIndex == OLTVSubscriptionsGroups) {
    return [self.groups count];
  }
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  
  NSURLRequest *urlRequest = nil;
  if (self.usersOrGroups.selectedSegmentIndex == OLTVSubscriptionsUsers) {
    
    OLTVUser *user = self.users[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    urlRequest = [NSURLRequest requestWithURL:user.imageURL];
    
  } else if (self.usersOrGroups.selectedSegmentIndex == OLTVSubscriptionsGroups) {
    
    OLTVGroup *group = self.groups[indexPath.row];
    cell.textLabel.text = group.name;
    urlRequest = [NSURLRequest requestWithURL:group.imageURL];
  }
  
  cell.imageView.image = nil;
  
  __weak UITableViewCell *weakCell = cell;
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
  if (self.usersOrGroups.selectedSegmentIndex == OLTVSubscriptionsUsers) {

    if (indexPath.row == [self.users count] - 5) {
      [self getSubscriptionsFromServer];
    }
    
  } else if (self.usersOrGroups.selectedSegmentIndex == OLTVSubscriptionsGroups) {
    
    if (indexPath.row == [self.groups count] - 5) {
      [self getSubscriptionsFromServer];
    }
    
  }
}

@end