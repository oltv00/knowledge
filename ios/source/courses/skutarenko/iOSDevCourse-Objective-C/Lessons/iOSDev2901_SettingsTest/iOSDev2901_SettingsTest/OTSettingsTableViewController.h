//
//  OTSettingsTableViewController.h
//  iOSDev2901_SettingsTest
//
//  Created by Oleg Tverdokhleb on 24.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTSettingsTableViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *levelControl;
@property (weak, nonatomic) IBOutlet UISwitch *shadowsSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *detalizationControl;
@property (weak, nonatomic) IBOutlet UISlider *soundSlider;
@property (weak, nonatomic) IBOutlet UISlider *musicSlider;

- (IBAction)actionTextChanged:(id)sender;
- (IBAction)actionValueChanged:(id)sender;

@end
