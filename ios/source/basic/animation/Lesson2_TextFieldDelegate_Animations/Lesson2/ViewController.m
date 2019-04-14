//
//  ViewController.m
//  Lesson2
//
//  Created by Oleg Tverdokhleb on 13.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

NS_ENUM(NSInteger) {
    stateFirst,
    stateSecond
} state;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControlAnimationState;

- (IBAction)actionChangeColors:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIColor*) randomColor {
    CGFloat r = (CGFloat)arc4random_uniform(256) / 255;
    CGFloat g = (CGFloat)arc4random_uniform(256) / 255;
    CGFloat b = (CGFloat)arc4random_uniform(256) / 255;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}

#pragma mark - Actions

- (IBAction)actionChangeColors:(id)sender {
    if (self.segmentedControlAnimationState.selectedSegmentIndex == 0) {
        [self firstAnimation];
        NSLog(@"firstAnimation");
    }
    else
        if (self.segmentedControlAnimationState.selectedSegmentIndex == 1) {
            [self secondAnimation];
            NSLog(@"secondAnimation");
        }
}

#pragma mark - Animations

- (void)secondAnimation {

    CGRect newLeftRect = self.leftView.frame;
    CGRect newRightRect = self.rightView.frame;
    
    newLeftRect.size.height += 100;
    newRightRect.size.height += 100;
    
    [UIView animateWithDuration:0.3f
                          delay:0
         usingSpringWithDamping:0.5f
          initialSpringVelocity:0.5f
                        options:UIViewAnimationOptionRepeat
                     animations:^{
                         
                         self.leftView.frame = newLeftRect;
                         self.rightView.frame = newRightRect;
                         
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (void)firstAnimation {
    const CGRect oldLeftViewPosition = self.leftView.frame;
    const CGRect oldRightViewPosition = self.rightView.frame;
    
    CGRect newLeftViewPosition = CGRectMake(CGRectGetMinX(oldLeftViewPosition),
                                            CGRectGetMinY(oldLeftViewPosition) + 100,
                                            CGRectGetWidth(oldLeftViewPosition),
                                            CGRectGetHeight(oldLeftViewPosition));
    
    CGRect newRightViewPosition = CGRectMake(CGRectGetMinX(oldRightViewPosition),
                                             CGRectGetMinY(oldRightViewPosition) + 100,
                                             CGRectGetWidth(oldRightViewPosition),
                                             CGRectGetHeight(oldRightViewPosition));
    
    if (state == stateFirst) {
        
        state = stateSecond;
        
        [UIView
         animateWithDuration:0.3f
         delay:0
         options:UIViewAnimationOptionCurveLinear
         animations:^{
             
             self.leftView.backgroundColor = [self randomColor];
             self.rightView.backgroundColor = [self randomColor];
             self.leftView.frame = newLeftViewPosition;
             self.rightView.frame = newRightViewPosition;
             
         }
         completion:^(BOOL finished) {
             
             if (finished) {
                 
                 [UIView animateWithDuration:0.3f animations:^{
                     self.leftView.frame = oldLeftViewPosition;
                     self.rightView.frame = oldRightViewPosition;
                 }];
                 
                 NSLog(@"First state end");
             }
         }];
        
    } else {
        
        state = stateFirst;
        
        [UIView
         animateWithDuration:0.3f
         delay:0
         options:UIViewAnimationOptionCurveEaseInOut
         animations:^{
             
             self.leftView.backgroundColor = [self randomColor];
             self.rightView.backgroundColor = [self randomColor];
             self.leftView.frame = newLeftViewPosition;
             self.rightView.frame = newRightViewPosition;
             
         }
         completion:^(BOOL finished) {
             if (finished) {
                 
                 [UIView animateWithDuration:0.3f animations:^{
                     self.leftView.frame = oldLeftViewPosition;
                     self.rightView.frame = oldRightViewPosition;
                 }];
                 
                 NSLog(@"Second state end");
             }
         }];
    }
}

















@end
