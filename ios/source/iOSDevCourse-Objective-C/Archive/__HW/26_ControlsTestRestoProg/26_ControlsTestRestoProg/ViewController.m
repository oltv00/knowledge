//
//  ViewController.m
//  26_ControlsTestRestoProg
//
//  Created by Oleg Tverdokhleb on 18.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setup methods

- (void) setup {
    [self viewImageChangeControl:0];
}

#pragma mark - Actions

- (IBAction)actionRotationSwitch:(UISwitch *)sender {
    if (sender.isOn){
        CGFloat randomRotation = (float)(arc4random() % (int)(M_PI * 2*10000)) / 10000 - M_PI;
        [UIView animateWithDuration:self.durationChangeSlider.value
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.animationView.transform = CGAffineTransformRotate(self.animationView.transform, randomRotation);
                         }
                         completion:^(BOOL finished) {
                             [self actionRotationSwitch:sender];
                         }];
    }
}

- (IBAction)actionScaleSwitch:(UISwitch *)sender {
    if (sender.isOn) {
        CGFloat scale = 1.f;
        if (CGRectGetWidth(self.animationView.frame) >= CGRectGetWidth(self.view.frame) / 2) {
            scale = 0.4f;
        } else
            scale = 1.6f;
        [UIView animateWithDuration:self.durationChangeSlider.value
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.animationView.transform = CGAffineTransformScale(self.animationView.transform, scale, scale);
                         }
                         completion:^(BOOL finished) {
                             [self actionScaleSwitch:sender];
                         }];
    }
}

- (IBAction)actionTranslationSwitch:(UISwitch *)sender {
    if (sender.isOn) {
        CGFloat dX = arc4random() % (int)CGRectGetWidth(self.view.frame);
        CGFloat dY = arc4random() % (int)CGRectGetHeight(self.view.frame) / 1.5f;
        [UIView animateWithDuration:self.durationChangeSlider.value
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.animationView.center = CGPointMake(dX, dY);
                         }
                         completion:^(BOOL finished) {
                             [self actionTranslationSwitch:sender];
                         }];
    }
}

- (IBAction)viewImageChangeControl:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.animationView.backgroundColor = [UIColor redColor];
            break;
        case 1:
            self.animationView.backgroundColor = [UIColor greenColor];
             break;
        case 2:
            self.animationView.backgroundColor = [UIColor blueColor];
            break;
        default:
            break;
    }
}
@end
