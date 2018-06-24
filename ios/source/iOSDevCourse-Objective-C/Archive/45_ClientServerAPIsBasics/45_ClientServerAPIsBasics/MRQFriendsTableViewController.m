//
//  MRQFriendsTableViewController.m
//  45_ClientServerAPIsBasics
//
//  Created by Oleg Tverdokhleb on 17.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQFriendsTableViewController.h"
#import "MRQServerManager.h"
#import "MRQUser.h"
#import "UIImageView+AFNetworking.h"

#import "MRQFriendsTableViewCell.h"

@interface MRQFriendsTableViewController ()

@property (strong, nonatomic) NSMutableArray *friendsArray;

@end

@implementation MRQFriendsTableViewController

static const NSInteger friendsRequest = 5;

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initial];
    [self cycles];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initial {
    self.friendsArray = [NSMutableArray array];
}

- (void)cycles {
    [self getFriendsFromServer];
}

#pragma mark - API

- (void)getFriendsFromServer {
    [[MRQServerManager sharedManager]
     getFriendsWithOffset:[self.friendsArray count]
     count:friendsRequest
     onSuccess:^(NSArray *friends) {
         
         [self.friendsArray addObjectsFromArray:friends];

         //animate update
         NSInteger startIndex = [self.friendsArray count] - [friends count];
         NSMutableArray *newPaths = [NSMutableArray array];
         for (; startIndex < [self.friendsArray count]; startIndex++) {
             [newPaths addObject:[NSIndexPath indexPathForRow:startIndex inSection:0]];
         }
         [self.tableView beginUpdates];
         [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationFade];
         [self.tableView endUpdates];
     }
     onFailure:^(NSError *error) {
         NSLog(@"error:%@", [error localizedDescription]);
     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.friendsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"friendsCell";
    
    MRQFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    MRQUser *user = [self.friendsArray objectAtIndex:indexPath.row];
    
    cell.userLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:user.imageURL];
    __weak MRQFriendsTableViewCell *weakCell = cell;
    [cell.userImage
     setImageWithURLRequest:request
     placeholderImage:nil
     
     success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
         weakCell.userImage.image = image;
         [weakCell layoutSubviews];
     }
     failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
         
     }];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = [self.friendsArray count] - 5;
    
    if ([cell.reuseIdentifier isEqualToString:@"friendsCell"] && indexPath.row == index) {
        [self getFriendsFromServer];
    }
}

@end
