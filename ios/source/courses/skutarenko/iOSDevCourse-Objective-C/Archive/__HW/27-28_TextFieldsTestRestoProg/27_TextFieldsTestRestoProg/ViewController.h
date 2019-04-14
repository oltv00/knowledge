//
//  ViewController.h
//  27_TextFieldsTestRestoProg
//
//  Created by Oleg Tverdokhleb on 20.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *textLabels;

- (IBAction)actionTextFieldToLabel:(UITextField *)sender;

@end

