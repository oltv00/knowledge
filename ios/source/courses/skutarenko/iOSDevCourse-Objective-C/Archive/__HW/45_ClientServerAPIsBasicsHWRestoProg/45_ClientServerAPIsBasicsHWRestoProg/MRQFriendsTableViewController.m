//
//  MRQFriendsTableViewController.m
//  45_ClientServerAPIsBasicsHWRestoProg
//
//  Created by Oleg Tverdokhleb on 17.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQFriendsTableViewController.h"
#import "MRQServerManager.h"
#import "MRQFriendsTableViewCell.h"
#import "MRQUser.h"
#import "UIImageView+AFNetworking.h"
#import "MRQDetailedUserViewController.h"

@interface MRQFriendsTableViewController ()

@property (strong, nonatomic) NSMutableArray *friendsArray;

@end

@implementation MRQFriendsTableViewController

static NSInteger friendsRequestCount = 5;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initial];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initial {
    self.friendsArray = [NSMutableArray array];
}

- (void)setup {
    [self getFriendsFromServer];
}

#pragma mark - API

- (void)getFriendsFromServer {
    
    [[MRQServerManager sharedManager]
     getFriendsWithOffset:[self.friendsArray count]
     count:friendsRequestCount
     onSuccess:^(NSArray *friends) {
         
         [self.friendsArray addObjectsFromArray:friends];
         
         //animate update
         NSInteger startIndexToUpdate = [self.friendsArray count] - [friends count];
         NSMutableArray *newPaths = [NSMutableArray array];
         for (; startIndexToUpdate < [self.friendsArray count]; startIndexToUpdate++) {
             [newPaths addObject:[NSIndexPath indexPathForRow:startIndexToUpdate inSection:0]];
         }
         [self.tableView beginUpdates];
         [self.tableView insertRowsAtIndexPaths:newPaths
                               withRowAnimation:UITableViewRowAnimationFade];
         [self.tableView endUpdates];
     }
     onFailure:^(NSError *error) {
         NSLog(@"%@", [error localizedDescription]);
     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.friendsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MRQFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendsCell"];
    
    MRQUser *user = [self.friendsArray objectAtIndex:indexPath.row];
    
    cell.userIDLabel.text = [NSString stringWithFormat:@"%@", user.uid];
    cell.firstNameLabel.text = user.firstName;
    cell.lastNameLabel.text = user.lastName;
    [cell.userImageView setImageWithURL:user.imageURL];
    
    cell.userImageView.layer.cornerRadius = cell.userImageView.frame.size.width/2;
    cell.userImageView.clipsToBounds = YES;
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 71.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MRQUser *user = [self.friendsArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"detailedUser" sender:user];
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"detailedUser"]) {
        
        MRQDetailedUserViewController *vc = [segue destinationViewController];
        
        MRQUser *user = (MRQUser *)sender;
        vc.userID = [user.uid integerValue];
    }
}

@end
