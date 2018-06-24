//
//  MainTableViewController.h
//  iOSDev4001_KVCHW
//
//  Created by Oleg Tverdokhleb on 18.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OLTVMainTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthField;

- (IBAction)actionFirstNameDidEnd:(UITextField *)sender;
- (IBAction)actionLastNameDidEnd:(UITextField *)sender;
- (IBAction)actionGenderControl:(UISegmentedControl *)sender;
- (IBAction)actionAverageGradeField:(UITextField *)sender;
- (IBAction)handleTapGesture:(UITapGestureRecognizer *)sender;


@end
