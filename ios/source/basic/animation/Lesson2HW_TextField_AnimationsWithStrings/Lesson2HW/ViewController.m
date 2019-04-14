//
//  ViewController.m
//  Lesson2HW
//
//  Created by Oleg Tverdokhleb on 14.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (assign, nonatomic) BOOL isEditing;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *labelPlaceholder;
@property (weak, nonatomic) IBOutlet UILabel *labelResultText;
@property (weak, nonatomic) IBOutlet UILabel *labelResult;
@property (weak, nonatomic) IBOutlet UILabel *labelTextColorPreview;

- (IBAction)actionTextFieldEditingChanged:(UITextField *)sender;
- (IBAction)actionTextColorSetButton:(id)sender;

@end

@implementation ViewController

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setup {
    self.labelPlaceholder.text = @"enter here the text...";
    self.isEditing = NO;
    self.labelTextColorPreview.backgroundColor = [UIColor blackColor];
}

#pragma mark - Action

- (IBAction)actionTextFieldEditingChanged:(UITextField *)sender {

    if (sender.text.length > 0 && self.isEditing == NO) {
        self.isEditing = YES;
        [self animationPlaceholderUp];
    } else
        if (sender.text.length == 0 && self.isEditing == YES) {
            self.isEditing = NO;
            [self animationPlaceholderDown];
        }
}

- (IBAction)actionTextColorSetButton:(id)sender {
    [self addTransitionToLabel:self.labelResultText];
    self.labelResultText.text = @"Does not work!";
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self addTransitionToLabel:self.labelResultText];
    self.labelResultText.text = textField.text;
    textField.text = @"";
    [self animationPlaceholderDown];
    self.isEditing = NO;
    [self resignFirstResponder];
    
    return YES;
}

#pragma mark - Animations

- (void)animationPlaceholderUp {
    CGRect newFrame = self.labelPlaceholder.frame;
    newFrame.origin.y -= 30;
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.labelPlaceholder.textColor = [UIColor redColor];
                         self.labelPlaceholder.frame = newFrame;
                     }];
}

- (void)animationPlaceholderDown {
    CGRect newFrame = self.labelPlaceholder.frame;
    newFrame.origin.y += 30;
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.labelPlaceholder.textColor = [UIColor lightGrayColor];
                         self.labelPlaceholder.frame = newFrame;
                     }];
}

- (void)addTransitionToLabel:(UILabel *) label {
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    transition.duration = 0.3f;
    [label.layer addAnimation:transition forKey:nil];
}























































@end
