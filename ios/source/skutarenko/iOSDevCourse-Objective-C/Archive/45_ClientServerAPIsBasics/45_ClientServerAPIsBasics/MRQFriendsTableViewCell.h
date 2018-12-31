//
//  MRQFriendTableViewCell.h
//  45_ClientServerAPIsBasics
//
//  Created by Oleg Tverdokhleb on 17.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRQFriendsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@end
