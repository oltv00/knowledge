//
//  MRQWallTableViewController.m
//  45_ClientServerAPIsBasicsHWRestoProg
//
//  Created by Oleg Tverdokhleb on 23.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQServerManager.h"
#import "MRQWallTableViewController.h"

@interface MRQWallTableViewController ()

@property (strong, nonatomic) NSMutableArray *wallArray;

@end

@implementation MRQWallTableViewController

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
    self.wallArray = [NSMutableArray array];
}

- (void) setup {
    [self getWallFromServerWithUserID:self.userID];
}

#pragma mark - API

- (void)getWallFromServerWithUserID:(NSInteger) userID {
    [[MRQServerManager sharedManager]
     getWallWithUserID:userID
     offset:[self.wallArray count]
     count:5
     onSuccess:^(NSArray *wall) {
         
         [self.wallArray addObjectsFromArray:wall];
         
     }
     onFailure:^(NSError *error) {
         NSLog(@"%@", [error localizedDescription]);
     }];
}

#pragma mark - UITableViewDataSource

#pragma mark - UITalbeViewDelegate

@end
