//
//  ViewController.m
//  iOSDev2601_ControlsTest
//
//  Created by Oleg Tverdokhleb on 23.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, ColorSchemeType) {
    ColorSchemeTypeRGB,
    ColorSchemeTypeHSV
};

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self refreshScreen];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Private
- (void)refreshScreen {
    CGFloat rValue = self.redComponentSlider.value;
    CGFloat gValue = self.greenComponentSlider.value;
    CGFloat bValue = self.blueComponentSlider.value;
    
    __block UIColor *color = nil;
    
    if (self.colorSchemeControl.selectedSegmentIndex == ColorSchemeTypeRGB) {
            color = [UIColor colorWithRed:rValue green:gValue blue:bValue alpha:1.0f];
//            self.infoLabel.text = [NSString stringWithFormat:@"RGB: {%1.2f, %1.2f, %1.2f}", rValue, gValue, bValue];
    } else {
            color = [UIColor colorWithHue:rValue saturation:gValue brightness:bValue alpha:1.0f];
//            self.infoLabel.text = [NSString stringWithFormat:@"HSV: {%1.2f, %1.2f, %1.2f}", rValue, gValue, bValue];
    }
    
    CGFloat hue;
    CGFloat saturation;
    CGFloat brightness;
    CGFloat alpha;
    
    NSString *result = @"";
    if ([color getRed:&rValue green:&gValue blue:&bValue alpha:&alpha]) {
        result = [result stringByAppendingFormat:@"RGB:{%1.2f, %1.2f, %1.2f}", rValue, gValue, bValue];
    } else {
        result = [result stringByAppendingFormat:@"RGB:{NO DATA}"];
    }
    
    if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
        result = [result stringByAppendingFormat:@" HSV:{%1.2f, %1.2f, %1.2f}", hue, saturation, brightness];
    } else {
        result = [result stringByAppendingFormat:@"HSV:{NO DATA}"];
    }
    self.infoLabel.text = result;
    self.resultView.backgroundColor = color;
}

#pragma mark - Actions
- (IBAction)actionSlider:(UISlider *)sender {
    [self refreshScreen];
}

- (IBAction)actionColorSchemeChanged:(UISegmentedControl *)sender {
    [self refreshScreen];
}

- (IBAction)actionEnabled:(UISwitch *)sender {
    self.redComponentSlider.enabled = sender.isOn;
    self.greenComponentSlider.enabled = sender.isOn;
    self.blueComponentSlider.enabled = sender.isOn;
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    });
}

@end
