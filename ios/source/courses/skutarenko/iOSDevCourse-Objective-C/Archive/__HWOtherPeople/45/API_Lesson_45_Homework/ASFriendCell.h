//
//  ASFriendCell.h
//  API_Lesson_45_Homework
//
//

#import <UIKit/UIKit.h>

@interface ASFriendCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imagePhoto;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UIView *onlineIndicator;

@end
