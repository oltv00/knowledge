//
//  ASSubscribersTableViewController.m
//  API_Lesson_45_Homework
//
//

#import "ASSubscribersTableViewController.h"
#import "ASFriendsTableViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ASServerManager.h"
#import "ASSubscriber.h"
#import "ASFriendCell.h"
#import "ASFriendPageTableViewController.h"

@interface ASSubscribersTableViewController ()


@property (strong, nonatomic) NSMutableArray* subscribersArray;
@property (assign, nonatomic) NSInteger currentUserID;
@property (assign, nonatomic) NSInteger countOfSub;


@end

@implementation ASSubscribersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.subscribersArray = [NSMutableArray array];
    
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

-(void) getSubscriberFromServerOfUserWithID: (NSInteger) userID {
    
    self.currentUserID = userID;
    
    [[ASServerManager sharedManager] getSubscriberOfUserWithID:userID
                                                        offset: [self.subscribersArray count]
                                                         count: 11
                                                     onSuccess: ^(NSArray *subscribers, NSInteger count) {
                                                         
                                                         [self.subscribersArray addObjectsFromArray:subscribers];
                                                         
                                                         
                                                         self.countOfSub = count;
                                                         
                                                         
                                                         NSMutableArray* newPaths = [NSMutableArray array];
                                                         
                                                         for (int i = (int)[self.subscribersArray count] - (int)[subscribers count]; i < [self.subscribersArray count]; i++) {
                                                             [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                                                         }
                                                         
                                                         [self.tableView beginUpdates];
                                                         
                                                         [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationTop];
                                                         
                                                         [self.tableView endUpdates];
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         //NSLog(@"YEEEEEAH %ld", [self.subscribersArray count]);
                                                         
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"error = %@, status code = %ld", [error localizedDescription], statusCode);
    }];
    
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.subscribersArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"FriendCell";
    
    ASFriendCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ASFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    ASSubscriber* subscriber = [self.subscribersArray objectAtIndex:indexPath.row];
    
    cell.fullNameLabel.text = [NSString stringWithFormat:@"%@", subscriber.name];
    
    
    NSURLRequest* request = [NSURLRequest requestWithURL:subscriber.imageURL];
    
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
    
    if ([self.subscribersArray count] < self.countOfSub) {
        [self getSubscriberFromServerOfUserWithID:self.currentUserID];
    }
    
}



@end
