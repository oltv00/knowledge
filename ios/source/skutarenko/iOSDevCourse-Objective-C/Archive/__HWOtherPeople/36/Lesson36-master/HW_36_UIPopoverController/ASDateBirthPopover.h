//
//  ASDateBirthPopover.h
//  HW_36_UIPopoverController
//
//  Created by MD on 04.07.15.
//  Copyright (c) 2015 hh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ASDateBirthPopoverDelegate <NSObject>

@required
- (void)dataFromDateBirthController:(NSString *)data;
@end



@interface ASDateBirthPopover : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, weak) id <ASDateBirthPopoverDelegate> delegate;

- (IBAction)pickerAction:(UIDatePicker *)sender;

@end
