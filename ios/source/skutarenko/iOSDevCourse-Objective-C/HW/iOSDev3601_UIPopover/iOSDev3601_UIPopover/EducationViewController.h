//
//  EducationTableViewController.h
//  iOSDev3601_UIPopover
//
//  Created by Oleg Tverdokhleb on 04.05.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EducationCheckBoxDelegate;
@class CheckboxTableViewCell;

@interface EducationViewController : UIViewController
@property (strong, nonatomic) NSString *checkBoxText;
@property (weak, nonatomic) id <EducationCheckBoxDelegate> delegate;
@end

@protocol EducationCheckBoxDelegate
@required
- (void)educationCheckBoxCell:(CheckboxTableViewCell *)checkBoxCell checkboxTextDidChanged:(NSString *)checkBoxText;
@end