//
//  ASFriendPageTableViewController.m
//  API_Lesson_45_Homework
//
//

#import "ASFriendPageTableViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ASServerManager.h"
#import "ASUserPage.h"
#import "ASSubscribersTableViewController.h"
#import "ASFollowersTableViewController.h"


@interface ASFriendPageTableViewController ()


@end

@implementation ASFriendPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.topItem.title = @"";
    
    self.tableView.separatorColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) getUserPageFromServerWithID: (NSInteger) userID {
    
    [[ASServerManager sharedManager] getUserPageWithID:userID onSuccess:^(NSArray *userData) {
        NSLog(@"Great");
        
        NSLog(@"THIS IS data from ASFriendPageTableViewController %ld", [userData count]);
        
        ASUserPage* friend = [userData firstObject];
        
        if (friend.city) {    // Это дата рождения. Мне было лень менять проперти)
            self.friendCity.text = [NSString stringWithFormat:@"%@", friend.city];
        } else {
            self.friendCity.text = @"";
        }
        
        
        
        self.currentUserID = friend.userIds;
        
        NSLog(@"Current user ID: %@", self.currentUserID);
        
        
        
        NSInteger onlineVar = [friend.isOnline integerValue];
        
        NSLog(@"USER is %@", onlineVar == 1 ? @"ONLINE" : @"OFFLINE");
        
        NSString* onlineString = [NSString stringWithFormat:@"%@", onlineVar == 1 ? @"Online" : @"Offline"];
        
        self.friendIsOnline.text = onlineString;
        
        self.friendFullName.text = [NSString stringWithFormat:@"%@ %@", friend.firstName, friend.lastName];
        
        
        
        self.navigationItem.title = friend.firstName;
        
        
        
        NSURLRequest* request = [NSURLRequest requestWithURL:friend.imageURL];
        
        self.friendImage.image = nil;
        
        [self.friendImage setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            self.friendImage.image = image;
            [self.friendImage layoutSubviews];
            
            NSLog(@"%@ %@ Setup = TRUE", friend.firstName, friend.lastName);
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
            NSLog(@"%@ %@ Setup = FALSE", friend.firstName, friend.lastName);
            
        }];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"Fail");
    }];
    
}



- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString: @"Subscribers"]) {
        
        ASSubscribersTableViewController *dest = [segue destinationViewController];
        [dest getSubscriberFromServerOfUserWithID: (int)[self.currentUserID integerValue]];
        
    } else if ([[segue identifier] isEqualToString: @"Followers"]) {
        
        ASFollowersTableViewController *dest = [segue destinationViewController];
        [dest getFollowerFromServerOfUserWithID:(int)[self.currentUserID integerValue]];
        
    }
}




@end













