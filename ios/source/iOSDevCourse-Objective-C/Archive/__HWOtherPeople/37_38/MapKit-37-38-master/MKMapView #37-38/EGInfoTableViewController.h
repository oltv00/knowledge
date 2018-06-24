//
//  EGInfoTableViewController.h
//  MKMapView #37-38
//
//  Created by Евгений Глухов on 27.08.15.
//  Copyright (c) 2015 EGApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EGInfoTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *userData;


@property (weak, nonatomic) UIImage* userAvatar;
@property (strong, nonatomic) NSString* userName;
@property (strong, nonatomic) NSString* userSurname;
@property (strong, nonatomic) NSString* userDateOfBirth;
@property (strong, nonatomic) NSString* userGender;
@property (strong, nonatomic) NSString* userAddress;




- (IBAction)BackButtonAction:(UIButton *)sender;



@end
