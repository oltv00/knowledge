//
//  MRQUserTableViewController.m
//  46-47_ClientServerAPIs
//
//  Created by Oleg Tverdokhleb on 24.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQServerManager.h"
#import "MRQUser.h"

#import "MRQUserTableViewController.h"

#import "MRQUserTableViewCell.h"

@interface MRQUserTableViewController ()

@property (assign, nonatomic) BOOL access;
@property (strong, nonatomic) MRQUser *user;

@end

@implementation MRQUserTableViewController

#pragma mark - VCLifeCycle

-(void)loadView {
    [super loadView];
    
    [self authorize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.access = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    if (self.access) {
//        self.access = NO;
//        [self authorize];
//    }
}

#pragma mark - API

- (void) authorize {
    [[MRQServerManager sharedManager]
     authorizeUser:^(MRQUser *user) {
         
         NSLog(@"%@ %@", user.firstName, user.lastName);
         
         self.user = user;
     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *userInfoIdentifier = @"userInfo";
    
    MRQUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userInfoIdentifier];

    cell.firstName.text = self.user.firstName;
    cell.lastName.text = self.user.lastName;
    
    return cell;
}

@end
