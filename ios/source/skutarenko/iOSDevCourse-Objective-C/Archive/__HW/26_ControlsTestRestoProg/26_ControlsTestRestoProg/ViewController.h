//
//  ViewController.h
//  26_ControlsTestRestoProg
//
//  Created by Oleg Tverdokhleb on 18.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *animationView;
@property (weak, nonatomic) IBOutlet UISlider *durationChangeSlider;

- (IBAction)actionRotationSwitch:(UISwitch *)sender;
- (IBAction)actionScaleSwitch:(UISwitch *)sender;
- (IBAction)actionTranslationSwitch:(UISwitch *)sender;

- (IBAction)viewImageChangeControl:(UISegmentedControl *)sender;

@end

