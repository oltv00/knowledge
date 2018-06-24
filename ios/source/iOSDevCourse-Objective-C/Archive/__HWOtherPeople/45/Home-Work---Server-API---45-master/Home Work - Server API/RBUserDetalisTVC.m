//
//  RBUserDetalisTVC.m
//  Home Work - Server API
//
//  Created by Roman Bogomolov on 16/10/14.
//  Copyright (c) 2014 Roman Bogomolov. All rights reserved.
//

#import "RBUserDetalisTVC.h"

@implementation RBUserDetalisTVC

- (void)awakeFromNib {
    // Initialization code

    self.userImage.frame = CGRectMake(0, 0, 100, 100);
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
    self.userImage.clipsToBounds = YES;
    self.userImage.layer.borderWidth = 3.0f;
    self.userImage.layer.borderColor = [[UIColor whiteColor] CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
