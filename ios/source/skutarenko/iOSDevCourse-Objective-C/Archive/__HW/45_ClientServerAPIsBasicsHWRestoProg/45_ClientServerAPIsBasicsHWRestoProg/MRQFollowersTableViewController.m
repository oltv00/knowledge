//
//  MRQFollowersTableViewController.m
//  45_ClientServerAPIsBasicsHWRestoProg
//
//  Created by Oleg Tverdokhleb on 22.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQServerManager.h"
#import "UIImageView+AFNetworking.h"

#import "MRQFollowersTableViewController.h"

#import "MRQFollower.h"

@interface MRQFollowersTableViewController ()

@property (strong, nonatomic) NSMutableArray *followersArray;
@property (assign, nonatomic) NSInteger countOfFollowers;

@end

@implementation MRQFollowersTableViewController

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
    self.followersArray = [NSMutableArray array];
}

- (void)setup {
    [self getFollowersByUserID:self.userID];
}

#pragma mark - API

- (void)getFollowersByUserID:(NSInteger) userID {
    [[MRQServerManager sharedManager]
     getFollowersWithUserID:userID
     offset:[self.followersArray count]
     count:5
     onSuccess:^(NSArray *followers, NSInteger count) {
         
         self.countOfFollowers = count;
         [self.followersArray addObjectsFromArray:followers];
         
         //animate update
         NSInteger index = [self.followersArray count] - [followers count];
         NSMutableArray *newPaths = [NSMutableArray array];
         for (; index < [self.followersArray count]; index++) {
             [newPaths addObject:[NSIndexPath indexPathForRow:index inSection:0]];
         }
         
         [self.tableView beginUpdates];
         [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationTop];
         [self.tableView endUpdates];
     }
     onFailure:^(NSError *error) {
         NSLog(@"%@", [error localizedDescription]);
     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.followersArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"followers"];

    MRQFollower *follower = [self.followersArray objectAtIndex:indexPath.row];
    aCell.textLabel.text = [NSString stringWithFormat:@"%@ %@", follower.firstName, follower.lastName];

    NSURLRequest *request = [NSURLRequest requestWithURL:follower.imageURL];
    __weak UITableViewCell *weakCell = aCell;
    [aCell.imageView setImageWithURLRequest:request
                           placeholderImage:[UIImage imageNamed:@"placeholder_image.png"]
                                    success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                                        weakCell.imageView.image = image;
                                        [weakCell layoutSubviews];
                                        
                                        weakCell.imageView.layer.cornerRadius = weakCell.imageView.frame.size.width/2;
                                        weakCell.imageView.clipsToBounds = YES;
                                    }
                                    failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                        NSLog(@"%@", [error localizedDescription]);
                                    }];
    
    
    return aCell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [self.followersArray count] - 5 && [self.followersArray count] != self.countOfFollowers) {
        [self getFollowersByUserID:self.userID];
    }
}

@end
