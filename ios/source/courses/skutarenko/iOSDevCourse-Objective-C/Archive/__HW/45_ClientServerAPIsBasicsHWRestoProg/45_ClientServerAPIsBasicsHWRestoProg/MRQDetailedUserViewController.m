//
//  MRQDetailedUserViewController.m
//  45_ClientServerAPIsBasicsHWRestoProg
//
//  Created by Oleg Tverdokhleb on 18.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQServerManager.h"
#import "UIImageView+AFNetworking.h"

#import "MRQDetailedUserViewController.h"
#import "MRQFollowersTableViewController.h"
#import "MRQSubscriptionsTableViewController.h"
#import "MRQWallTableViewController.h"

#import "MRQDetailedUser.h"

@interface MRQDetailedUserViewController ()

@property (weak, nonatomic) IBOutlet UIButton *followersButton;

- (IBAction)actionFollowersButton:(id)sender;

@end

@implementation MRQDetailedUserViewController

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initial];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initial {
}

- (void)setup {
    [self getUserWithID:self.userID];
}

- (void) configureView:(NSArray *) userInfo {
    
    MRQDetailedUser *user = [userInfo firstObject];
    
    [self.navigationItem setTitle:user.firstName];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    #warning repair this button
    self.followersButton.titleLabel.text = [NSString stringWithFormat:@"%ld", [user.followersCount integerValue]];
    [self.imageView setImageWithURL:user.imageURL];
}

#pragma mark - API

- (void)getUserWithID:(NSInteger) userID {
    [[MRQServerManager sharedManager]
     getDetailedUserWithID:userID
     onSuccess:^(NSArray *userInfo) {
         
         [self configureView:userInfo];
     }
     onFailure:^(NSError *error) {
         NSLog(@"%@", [error localizedDescription]);
     }];
}

#pragma mark - Action

- (IBAction)actionFollowersButton:(id)sender {
    [self performSegueWithIdentifier:@"followersSegue" sender:nil];
}

- (IBAction)actionSubsButton:(id)sender {
    [self performSegueWithIdentifier:@"subsSegue" sender:nil];
}

- (IBAction)actionWallButton:(id)sender {
    [self performSegueWithIdentifier:@"wallSegue" sender:nil];
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
#warning use switch
    
    if ([segue.destinationViewController isKindOfClass:[MRQFollowersTableViewController class]]) {
        
        MRQFollowersTableViewController *vc = [segue destinationViewController];
        vc.userID = self.userID;
    }
    
    if ([segue.destinationViewController isKindOfClass:[MRQSubscriptionsTableViewController class]]) {
        
        MRQSubscriptionsTableViewController *vc = [segue destinationViewController];
        vc.userID = self.userID;
    }
    
    if ([segue.destinationViewController isKindOfClass:[MRQWallTableViewController class]]) {
        
        MRQWallTableViewController *vc = [segue destinationViewController];
        vc.userID = self.userID;
    }
}

@end
