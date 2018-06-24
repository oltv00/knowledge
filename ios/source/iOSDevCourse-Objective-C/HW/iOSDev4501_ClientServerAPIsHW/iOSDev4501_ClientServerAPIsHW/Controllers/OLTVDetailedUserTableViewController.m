//
//  OLTVDetailedUserTableViewController.m
//  iOSDev4501_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 04/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVDetailedUserTableViewController.h"

//API
#import "../API/OLTVAPIServerManager.h"

//Model
#import "../Model/OLTVDetailedUser.h"

//Libs
#import "../Libs/UIKit+AFNetworking/UIImageView+AFNetworking.h"

//Controllers
#import "../Controllers/OLTVSubscriptionsTableViewController.h"
#import "../Controllers/OLTVFollowersTableViewController.h"
#import "../Controllers/OLTVWallTableViewController.h"

//Categories
#import "../Categories/UIViewController+HideBackBarButtonItem.h"

@interface OLTVDetailedUserTableViewController ()

@property (strong, nonatomic) OLTVDetailedUser *detailedUser;

@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *subscriptionsButton;
@property (weak, nonatomic) IBOutlet UIButton *followersButton;

@end

@implementation OLTVDetailedUserTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self hideBackBarButtonItem];
  [self getUserFromServer];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)updateContent {
  [self.image setImageWithURL:self.detailedUser.imageURL];
  self.fullName.text = [NSString stringWithFormat:@"%@ %@", self.detailedUser.firstName, self.detailedUser.lastName];
}

#pragma mark - API

- (void)getUserFromServer {
  [[OLTVAPIServerManager sharedManager]
   getUserWithID:self.userID
   onSuccess:^(OLTVDetailedUser *user) {
     self.detailedUser = user;
     [self updateContent];
   }
   onFailure:^(NSError *error) {
     NSLog(@"error = %@", [error localizedDescription]);
   }];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"showSubscriptions"]) {
    OLTVSubscriptionsTableViewController *vc = segue.destinationViewController;
    vc.userID = self.userID;
  }
  
  if ([segue.identifier isEqualToString:@"showFollowers"]) {
    OLTVFollowersTableViewController *vc = segue.destinationViewController;
    vc.userID = self.userID;
  }
  
  if ([segue.identifier isEqualToString:@"showWall"]) {
    OLTVWallTableViewController *vc = segue.destinationViewController;
    vc.userID = self.userID;
  }
}

@end