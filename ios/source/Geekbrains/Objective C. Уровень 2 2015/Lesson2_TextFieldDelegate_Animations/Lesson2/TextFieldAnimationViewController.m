//
//  TextFieldAnimationViewController.m
//  Lesson2
//
//  Created by Oleg Tverdokhleb on 13.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "TextFieldAnimationViewController.h"

NS_ENUM(NSInteger, PhPosition) {
    PhPositionNormal,
    PhPositionUpped
};

NS_ENUM(NSInteger, ChangeStateText) {
    ChangeStateTextFirst,
    ChangeStateTextSecond
};

@interface TextFieldAnimationViewController ()

@property (strong, nonatomic) IBOutletCollection(id) NSArray *allUserInterface;
@property (strong, nonatomic) IBOutletCollection(id) NSArray *allUserInterfaceWithSlider;

@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UILabel *labelPlaceholderName;
@property (weak, nonatomic) IBOutlet UILabel *labelChange;

- (IBAction)actionTextFieldName:(UITextField *)sender;
- (IBAction)actionChangeButton:(id)sender;
- (IBAction)actionSliderValueChanged:(UISlider *)sender;
- (IBAction)actionSwitchValueChanged:(UISwitch *)sender;

@end

@implementation TextFieldAnimationViewController

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    PhPosition = PhPositionNormal;
    NSString *defaultPlaceHolderName = @"Введите имя";
    self.labelPlaceholderName.text = NSLocalizedString(defaultPlaceHolderName, nil);
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(endEditing:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)endEditing:(UITapGestureRecognizer *) tapGesture {
    [self.view endEditing:YES];
}

#pragma mark - Action

- (IBAction)actionTextFieldName:(UITextField *)sender {
    
    if (sender.text.length != 0 && PhPosition == PhPositionNormal) {
        PhPosition = PhPositionUpped;
        [self animationPlaceholderNameUP];
        
    } else if (sender.text.length == 0 && PhPosition == PhPositionUpped) {
        
        PhPosition = PhPositionNormal;
        [self animationPlaceholderNameDOWN];
    }
}

- (IBAction)actionChangeButton:(id)sender {
    
    [self addTransitionToLabel:self.labelChange];
    
    if (ChangeStateText == ChangeStateTextFirst) {
        ChangeStateText = ChangeStateTextSecond;
        
        self.labelChange.text = @"First State";
        self.labelChange.textColor = [UIColor blueColor];

    } else
        if (ChangeStateText == ChangeStateTextSecond) {
            ChangeStateText = ChangeStateTextFirst;
            
            self.labelChange.text = @"Second state";
            self.labelChange.textColor = [UIColor redColor];
        }
}

- (IBAction)actionSliderValueChanged:(UISlider *)sender {
    
    for (UIView *view in self.allUserInterface) {
        view.alpha = sender.value;
    }
}

- (IBAction)actionSwitchValueChanged:(UISwitch *)sender {

    for (UIControl *view in self.allUserInterfaceWithSlider) {
        view.userInteractionEnabled = sender.isOn;
        view.enabled = sender.isOn;
    }
}

#pragma mark - Animation

- (void)animationPlaceholderNameUP {
    
    CGRect newRect = self.labelPlaceholderName.frame;
    newRect.origin.y -= 30;
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         self.labelPlaceholderName.frame = newRect;
                         self.labelPlaceholderName.textColor = [UIColor redColor];
                         
                     }];
    
}

- (void)animationPlaceholderNameDOWN {
    
    CGRect newRect = self.labelPlaceholderName.frame;
    newRect.origin.y += 30;
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         self.labelPlaceholderName.frame = newRect;
                         self.labelPlaceholderName.textColor = [UIColor lightGrayColor];
                         
                     }];
    
}

- (void)addTransitionToLabel:(UILabel *) label {
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    transition.duration = 0.3f;
    [label.layer addAnimation:transition forKey:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.textFieldName]) {
        [textField resignFirstResponder];
    }
    return YES;
}
@end
