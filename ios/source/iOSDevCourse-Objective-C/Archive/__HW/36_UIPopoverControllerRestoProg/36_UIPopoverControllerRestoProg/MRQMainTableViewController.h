//
//  MRQMainTableViewController.h
//  36_UIPopoverControllerRestoProg
//
//  Created by Oleg Tverdokhleb on 20.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRQMainTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *lastName;

@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthTextField;
@property (weak, nonatomic) IBOutlet UITextField *educationTextField;

@end
