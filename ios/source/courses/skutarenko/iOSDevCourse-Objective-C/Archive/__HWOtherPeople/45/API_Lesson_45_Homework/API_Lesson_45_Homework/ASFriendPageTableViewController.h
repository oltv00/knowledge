//
//  ASFriendPageTableViewController.h
//  API_Lesson_45_Homework
//
//

#import <UIKit/UIKit.h>

@interface ASFriendPageTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *friendImage;
@property (weak, nonatomic) IBOutlet UILabel *friendFullName;
@property (weak, nonatomic) IBOutlet UILabel *friendIsOnline;
@property (weak, nonatomic) IBOutlet UILabel *friendCity;


@property (assign, nonatomic) NSInteger subscriptions;


@property (strong, nonatomic) NSString* currentUserID;


-(void) getUserPageFromServerWithID: (NSInteger) userID;



@end
