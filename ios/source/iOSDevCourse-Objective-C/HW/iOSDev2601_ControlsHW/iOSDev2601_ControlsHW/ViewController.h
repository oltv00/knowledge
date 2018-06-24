//
//  ViewController.h
//  iOSDev2601_ControlsHW
//
//  Created by Oleg Tverdokhleb on 23.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISwitch *rotationSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *scaleSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *translationSwitch;
@property (weak, nonatomic) IBOutlet UISlider *durationSlider;

- (IBAction)actionRotationSwitchValueChanged:(UISwitch *)sender;
- (IBAction)actionScaleSwitchValueChanged:(UISwitch *)sender;
- (IBAction)actionTranslationSwitchValueChanged:(UISwitch *)sender;
- (IBAction)actionDurationSliderValueChanged:(UISlider *)sender;
- (IBAction)actionPictureChangedSegmentedControl:(UISegmentedControl *)sender;

@end

