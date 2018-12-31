//
//  ASDetailsViewController.h
//  HW_36_UIPopoverController
//
//  Created by MD on 03.07.15.
//  Copyright (c) 2015 hh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelFamaly;
@property (weak, nonatomic) IBOutlet UILabel *labelGender;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelEducation;

@property (strong, nonatomic) NSString* dataName;
@property (strong, nonatomic) NSString* dataFamaly;
@property (strong, nonatomic) NSString* dataGender;
@property (strong, nonatomic) NSString* dataEducation;
@property (strong, nonatomic) NSString* dataDateBirth;


@property (strong, nonatomic) NSArray* dataСhecking;
- (IBAction)sendToServer:(UIButton *)sender;

@end
