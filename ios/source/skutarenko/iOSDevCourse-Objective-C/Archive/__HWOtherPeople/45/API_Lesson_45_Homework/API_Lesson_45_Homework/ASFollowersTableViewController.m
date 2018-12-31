//
//  ASFollowersTableViewController.m
//  API_Lesson_45_Homework
//
//

#import "ASFollowersTableViewController.h"
#import "ASFriendsTableViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ASServerManager.h"
#import "ASFollower.h"
#import "ASFriendCell.h"
#import "ASFriendPageTableViewController.h"

@interface ASFollowersTableViewController ()

@property (strong, nonatomic) NSMutableArray* followersArray;
@property (assign, nonatomic) NSInteger currentUserID;
@property (assign, nonatomic) NSInteger countOfSub;


@end

@implementation ASFollowersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        self.followersArray = [NSMutableArray array];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

-(void) getFollowerFromServerOfUserWithID: (NSInteger) userID {
    NSLog(@"getFollowerFromServerOfUserWithID");
    self.currentUserID = userID;
    
    [[ASServerManager sharedManager] getFollowersOfUserWithID:userID
                                                        offset: [self.followersArray count]
                                                         count: 11
                                                     onSuccess: ^(NSArray *subscribers, NSInteger count) {
                                                         
                                                         [self.followersArray addObjectsFromArray:subscribers];
                                                         
                                                         
                                                         self.countOfSub = count;
                                                         
                                                         
                                                         NSMutableArray* newPaths = [NSMutableArray array];
                                                         
                                                         for (int i = (int)[self.followersArray count] - (int)[subscribers count]; i < [self.followersArray count]; i++) {
                                                             [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                                                         }
                                                         
                                                         [self.tableView beginUpdates];
                                                         
                                                         [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationTop];
                                                         
                                                         [self.tableView endUpdates];
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         //NSLog(@"YEEEEEAH %ld", [self.followersArray count]);
                                                         
                                                         
                                                     } onFailure:^(NSError *error, NSInteger statusCode) {
                                                         NSLog(@"error = %@, status code = %ld", [error localizedDescription], statusCode);
                                                     }];
    
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.followersArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"FriendCell";
    
    ASFriendCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ASFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    ASFollower* follower = [self.followersArray objectAtIndex:indexPath.row];
    
    cell.fullNameLabel.text = [NSString stringWithFormat:@"%@", follower.name];
    
    
    NSURLRequest* request = [NSURLRequest requestWithURL:follower.imageURL];
    
    __weak ASFriendCell* weackCell = cell;
    
    cell.imagePhoto.image = nil;
    
    cell.onlineIndicator.backgroundColor = [UIColor clearColor];
    
    cell.imagePhoto.layer.cornerRadius = cell.imagePhoto.frame.size.width/2;
    cell.imagePhoto.clipsToBounds = YES;
    
    [cell.imagePhoto setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        weackCell.imagePhoto.image = image;
        [weackCell layoutSubviews];
        
        //NSLog(@"Setup = TRUE");
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
        NSLog(@"Setup = FALSE");
        
    }];
    
    
    return cell;
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52.f;
}


- (void)scrollViewDidScroll: (UIScrollView *)scroll {
    
    if ([self.followersArray count] < self.countOfSub) {
        [self getFollowerFromServerOfUserWithID:self.currentUserID];
    }
    
}

@end
