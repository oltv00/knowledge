//
//  RBUserDetalisTVC.h
//  Home Work - Server API
//
//  Created by Roman Bogomolov on 16/10/14.
//  Copyright (c) 2014 Roman Bogomolov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBUserDetalisTVC : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (weak, nonatomic) IBOutlet UILabel *onlineStatus;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@property (weak, nonatomic) IBOutlet UILabel *followersCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *subCountLabel;

@end
