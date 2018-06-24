//
//  AZViewController.h
//  HypnoCircle
//
//  Created by Alex Alexandrov on 28.12.13.
//  Copyright (c) 2013 Alex Zbirnik. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    
    AZHypnoCircleSmall,
    AZHypnoCircleMiddle,
    AZHypnoCircleLarge
    
}AZHypnoCircle;

typedef enum{
    
    AZcolorChannelRed,
    AZcolorChannelGreen,
    AZcolorChannelBlue
    
}AZcolorChannel;

@interface AZViewController : UIViewController

@property (strong, nonatomic) UIView *smallCircleView;
@property (strong, nonatomic) UIImageView *smallCircleImageView;

@property (strong, nonatomic) UIView *middleCircleView;
@property (strong, nonatomic) UIImageView *middleCircleImageView;

@property (strong, nonatomic) UIView *largeCircleView;
@property (strong, nonatomic) UIImageView *largeCircleImageView;


@property (weak, nonatomic) IBOutlet UISegmentedControl *choiceCircleSegmentedControl;

@property (weak, nonatomic) IBOutlet UILabel *scaleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scaleSizeLabel;
@property (weak, nonatomic) IBOutlet UISlider *scaleSlider;

@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedSizeLabel;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;

@property (weak, nonatomic) IBOutlet UILabel *colorLabel;

@property (weak, nonatomic) IBOutlet UILabel *colorRedLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorRedSizeLabel;
@property (weak, nonatomic) IBOutlet UISlider *colorRedSlider;

@property (weak, nonatomic) IBOutlet UILabel *colorGreenLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorGreenSizeLabel;
@property (weak, nonatomic) IBOutlet UISlider *colorGreenSlider;

@property (weak, nonatomic) IBOutlet UILabel *colorBlueLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorBlueSizeLabel;
@property (weak, nonatomic) IBOutlet UISlider *colorBlueSlider;

@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UISwitch *startSwitch;

@property (weak, nonatomic) IBOutlet UILabel *visibleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *visibleSwitch;


- (IBAction)choiceCircleAction:(id)sender;

- (IBAction)changeScaleCircleAction:(id)sender;
- (IBAction)changeSpeedCircleAction:(UISlider *)sender;


- (IBAction)changeColorRedCircleAction:(UISlider *)sender;
- (IBAction)changeColorGreenCircleAction:(UISlider *)sender;
- (IBAction)changeColorBlueCircleAction:(UISlider *)sender;

- (IBAction)startMoveCircleAction:(UISwitch *)sender;

- (IBAction)visibleAnyControlsAction:(UISwitch *)sender;


@end
