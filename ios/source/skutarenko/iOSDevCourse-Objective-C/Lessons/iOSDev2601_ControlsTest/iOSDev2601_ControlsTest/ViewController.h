//
//  ViewController.h
//  iOSDev2601_ControlsTest
//
//  Created by Oleg Tverdokhleb on 23.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *redComponentSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenComponentSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueComponentSlider;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIView *resultView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSchemeControl;

- (IBAction)actionSlider:(UISlider *)sender;
- (IBAction)actionEnabled:(UISwitch *)sender;
- (IBAction)actionColorSchemeChanged:(UISegmentedControl *)sender;

@end

