//
//  MainViewController.h
//  HW_36_UIPopoverController
//
//  Created by MD on 03.07.15.
//  Copyright (c) 2015 hh. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MainViewController : UITableViewController <UITextFieldDelegate , UIPopoverControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>



- (IBAction)infoBarButtonItem:(UIBarButtonItem *)sender;

@end
