//
//  ViewController.m
//  26_ControlsTest
//
//  Created by Oleg Tverdokhleb on 17.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

typedef enum {
    MRQColorSchemeTypeRGB,
    MRQColorSchemeTypeHSV
} MRQColorSchemeType;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.colorSchemeControl.selectedSegmentIndex = MRQColorSchemeTypeRGB;
    // Do any additional setup after loading the view, typically from a nib.
    
    [self updateScreenWithSliderColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Supporting methods

- (void) updateScreenWithSliderColor {
    
    CGFloat red = self.redComponentSlider.value;
    CGFloat green = self.greenComponentSlider.value;
    CGFloat blue = self.blueComponentSlider.value;
    CGFloat alpha = self.alphaComponentSlider.value;
    
    CGFloat hue, saturation, brightbess;
    UIColor *color = nil;
    NSString *result = @"";
    
    if (self.colorSchemeControl.selectedSegmentIndex == MRQColorSchemeTypeRGB) {
        color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    } else {
        color = [UIColor colorWithHue:red saturation:green brightness:blue alpha:alpha];
    }
    
    if ([color getRed:&red green:&green blue:&blue alpha:&alpha]) {
        result = [NSString stringWithFormat:@"RGB:{%1.2f : %1.2f : %1.2f : %1.2f}", red, green, blue, alpha];
    } else {
        result = [NSString stringWithFormat:@"RGB:NO DATA"];
    }
    
    if ([color getHue:&hue saturation:&saturation brightness:&brightbess alpha:&alpha]) {
        result = [result stringByAppendingFormat:@"\nHSV:{%1.2f : %1.2f : %1.2f : %1.2f}", hue, saturation, brightbess, alpha];
    } else {
        result = [result stringByAppendingFormat:@"\nHSV:NO DATA"];
    }
    
    self.infoLabel.text = result;
    self.view.backgroundColor = color;
}

#pragma mark - Actions

- (IBAction)actionValueChangedSlider:(UISlider *)sender {
    
    [self updateScreenWithSliderColor];
}

- (IBAction)actionEnableColorsChange:(UISwitch *)sender {
    //NSLog(@"actionEnableColorsChange");
    
    self.redComponentSlider.enabled = sender.isOn;
    self.greenComponentSlider.enabled = sender.isOn;
    self.blueComponentSlider.enabled = sender.isOn;
    
    /*
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    });
    */
}

@end
