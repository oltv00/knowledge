//
//  ViewController.h
//  27_TextFieldsTest
//
//  Created by Oleg Tverdokhleb on 20.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

- (IBAction) actionLoginPressButton:(UIButton *)sender;
- (IBAction) actionTextChanged:(UITextField *)sender;

@end

