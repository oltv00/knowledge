//
//  ViewController.m
//  iOSDev2601_ControlsHW
//
//  Created by Oleg Tverdokhleb on 23.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSArray *images;
@property (assign, nonatomic) float animationDuration;
@property (assign, nonatomic) CGAffineTransform defaultTransform;
@property (assign, nonatomic) CGPoint defaultCenter;
@end

@implementation ViewController

#pragma mark - View lifecycles
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initial];
    [self initialImages];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.defaultTransform = self.imageView.transform;
    self.defaultCenter = self.imageView.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private
- (void)initial {
    self.animationDuration = self.durationSlider.value;
}

- (void)initialImages {
    UIImage *image1 = [UIImage imageWithContentsOfFile:@"/Users/oltv00/Documents/Objective-C/IOSDevCourse/_SECOND_/___HWs/iOSDev2601_ControlsHW/iOSDev2601_ControlsHW/Pics/1.png"];
    UIImage *image2 = [UIImage imageWithContentsOfFile:@"/Users/oltv00/Documents/Objective-C/IOSDevCourse/_SECOND_/___HWs/iOSDev2601_ControlsHW/iOSDev2601_ControlsHW/Pics/2.png"];
    UIImage *image3 = [UIImage imageWithContentsOfFile:@"/Users/oltv00/Documents/Objective-C/IOSDevCourse/_SECOND_/___HWs/iOSDev2601_ControlsHW/iOSDev2601_ControlsHW/Pics/3.png"];
    self.images = @[image1, image2, image3];
    self.imageView.image = image1;
}

- (void)refreshView {
    if (!self.translationSwitch.isOn && !self.scaleSwitch.isOn && !self.rotationSwitch.isOn) {
        [UIView animateWithDuration:1.f animations:^{
            self.imageView.transform = self.defaultTransform;
            self.imageView.center = self.defaultCenter;
        }];
    }
}

#pragma mark - Animations
- (void)rotateAnimation {
    if (self.rotationSwitch.isOn) {
        [UIView animateWithDuration:self.animationDuration delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
            CGAffineTransform currentTransform = self.imageView.transform;
            self.imageView.transform = CGAffineTransformRotate(currentTransform, M_PI_2);
        } completion:^(BOOL finished) {
            [self rotateAnimation];
        }];
    }
}

- (void)scaleAnimation {
    if (self.scaleSwitch.isOn) {
        CGFloat imageWidth = CGRectGetWidth(self.imageView.frame);
        CGFloat viewWidth = CGRectGetWidth(self.view.frame);
        
        CGFloat scale = (imageWidth >= viewWidth) ? 0.6f : 1.4f;
        
        [UIView animateWithDuration:self.animationDuration delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
            CGAffineTransform currentTransform = self.imageView.transform;
            self.imageView.transform = CGAffineTransformScale(currentTransform, scale, scale);
        } completion:^(BOOL finished) {
            [self scaleAnimation];
        }];
    }
}

- (void)translateAnimation {
    if (self.translationSwitch.isOn) {
        CGFloat viewWidth = CGRectGetWidth([self.imageView superview].frame);
        CGFloat viewHeight = CGRectGetHeight([self.imageView superview].frame);
        CGFloat tx = arc4random_uniform(viewWidth);
        CGFloat ty = arc4random_uniform(viewHeight);
        
        [UIView animateWithDuration:self.animationDuration delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
            self.imageView.center = CGPointMake(tx, ty);
        } completion:^(BOOL finished) {
            [self translateAnimation];
        }];
    }
}

#pragma mark - Actions
- (IBAction)actionRotationSwitchValueChanged:(UISwitch *)sender {
    [self rotateAnimation];
    [self refreshView];
}

- (IBAction)actionScaleSwitchValueChanged:(UISwitch *)sender {
    [self scaleAnimation];
    [self refreshView];
}

- (IBAction)actionTranslationSwitchValueChanged:(UISwitch *)sender {
    [self translateAnimation];
    [self refreshView];
}

- (IBAction)actionDurationSliderValueChanged:(UISlider *)sender {
    self.animationDuration = 0.75f/sender.value;
    NSLog(@"%f", self.animationDuration);
}

- (IBAction)actionPictureChangedSegmentedControl:(UISegmentedControl *)sender {
    self.imageView.image = self.images[sender.selectedSegmentIndex];
}

@end
