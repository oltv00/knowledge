//
//  AZViewController.m
//  HypnoCircle
//
//  Created by Alex Alexandrov on 28.12.13.
//  Copyright (c) 2013 Alex Zbirnik. All rights reserved.
//

#import "AZViewController.h"

@interface AZViewController ()

@property (weak, nonatomic) UIView *selectedView;
@property (weak, nonatomic) UIImageView *selectedImageView;
@property (assign, nonatomic) CGFloat selectiveSpeed;

@end

@implementation AZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.largeCircleView = [self createHypnoImageView:CGRectMake(70, 25, 180, 180)
                                            rectInset:5
                                         andImageView:self.largeCircleImageView];
    
    self.middleCircleView = [self createHypnoImageView:CGRectMake(115, 70, 90, 90)
                                             rectInset:4
                                          andImageView:self.middleCircleImageView];
    
    self.smallCircleView = [self createHypnoImageView:CGRectMake(137.5, 92.5, 45, 45)
                                            rectInset:2
                                         andImageView:self.smallCircleImageView];

    self.selectedView = self.smallCircleView;
    self.selectedImageView = self.smallCircleImageView;
    self.selectiveSpeed = 0.5;
}

#pragma mark - private method

- (UIView *) createHypnoImageView: (CGRect) rectView rectInset: (CGFloat) rectInset andImageView: (UIImageView *) imageView{
    
    UIView *localView = [[UIView alloc] initWithFrame:rectView];
    localView.backgroundColor = [UIColor lightGrayColor];
    localView.alpha = 1.0f;
    localView.layer.cornerRadius = CGRectGetWidth(rectView) / 2;
    [self.view addSubview:localView];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectInset(CGRectMake(0, 0, CGRectGetWidth(rectView),
                                                                          CGRectGetHeight(rectView)), rectInset, rectInset)];
    
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.image = [UIImage imageNamed:@"hypnoCircle.png"];
    [localView addSubview:imageView];

    return localView;
}

- (void) refreshColorCircle{
    
    CGFloat colorRed = self.colorRedSlider.value;
    CGFloat colorGreen = self.colorGreenSlider.value;
    CGFloat colorBlue = self.colorBlueSlider.value;
    
    UIColor *bgColor = [UIColor colorWithRed:colorRed
                                       green:colorGreen
                                        blue:colorBlue
                                       alpha:1.0f];
    
    self.selectedView.backgroundColor = self.colorLabel.textColor = bgColor;
}

- (void) changeScaleHypnoCircle: (UIView *) circleView andImageView: (UIImageView *) imageView{
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         circleView.transform = CGAffineTransformMakeScale(self.scaleSlider.value, self.scaleSlider.value);
                         imageView.transform = CGAffineTransformMakeScale(self.scaleSlider.value, self.scaleSlider.value);
                     }];
  
}

- (void) changeColorChannel: (UILabel *) colorLabel colorSizeLabel: (UILabel *) colorSizeLabel andColorSlider: (UISlider *) colorSlider{
    
    colorSizeLabel.text = [NSString stringWithFormat:@"%.2f", colorSlider.value];
    
    UIColor *anyColor = [[UIColor alloc] init];
    
    switch (colorSlider.tag) {
            
        case AZcolorChannelRed:
            anyColor = [UIColor colorWithRed:colorSlider.value
                                       green:0
                                        blue:0
                                       alpha:1.0f];
            break;
            
        case AZcolorChannelGreen:
            anyColor = [UIColor colorWithRed:0
                                       green:colorSlider.value
                                        blue:0
                                       alpha:1.0f];
            break;
            
        case AZcolorChannelBlue:
            anyColor = [UIColor colorWithRed:0
                                       green:0
                                        blue:colorSlider.value
                                       alpha:1.0f];
            break;
    }
 
    colorSizeLabel.textColor =
    colorLabel.textColor =
    colorSlider.tintColor = anyColor;
    
}

- (void) rotationView: (UIView *) viewRotate rotationAngle: (double_t) angleRotate{
    
    CGAffineTransform currentTransform = viewRotate.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, angleRotate);
    
    [UIView animateKeyframesWithDuration:self.speedSlider.value
                                   delay:0
                                 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState
                              animations:^{
                                  
                                  viewRotate.transform = newTransform;
                                  
                              }
                              completion:^(BOOL finished) {
                                  
                                  __weak UIView *minorView = viewRotate;
                                  
                                  if(self.startSwitch.isOn){
                                      [self rotationView:minorView rotationAngle:angleRotate];
                                  }
                              }];
    
}


#pragma mark - Actions

- (IBAction)choiceCircleAction:(id)sender {
    
    switch (self.choiceCircleSegmentedControl.selectedSegmentIndex) {
            
        case AZHypnoCircleSmall:
            self.selectedView = self.smallCircleView;
            self.selectedImageView = self.smallCircleImageView;
            break;
            
        case AZHypnoCircleMiddle:
            self.selectedView = self.middleCircleView;
            self.selectedImageView = self.middleCircleImageView;
            break;
            
        case AZHypnoCircleLarge:
            self.selectedView = self.largeCircleView;
            self.selectedImageView = self.largeCircleImageView;
            break;
    }
}

- (IBAction)changeScaleCircleAction:(id)sender {
    
    self.scaleSizeLabel.text = [NSString stringWithFormat:@"%.2f", self.scaleSlider.value];
    
    [self changeScaleHypnoCircle:self.selectedView andImageView:self.selectedImageView];

}

- (IBAction)changeSpeedCircleAction:(UISlider *)sender {
    
    self.speedSizeLabel.text = [NSString stringWithFormat:@"%.2f", self.speedSlider.value];
    //self.selectiveSpeed = self.speedSlider.value;
}

- (IBAction)changeColorRedCircleAction:(UISlider *)sender {
    
        [self changeColorChannel:self.colorRedLabel
              colorSizeLabel:self.colorRedSizeLabel
              andColorSlider:self.colorRedSlider];
    
    [self refreshColorCircle];
    
}

- (IBAction)changeColorGreenCircleAction:(UISlider *)sender {
    
    [self changeColorChannel:self.colorGreenLabel
              colorSizeLabel:self.colorGreenSizeLabel
              andColorSlider:self.colorGreenSlider];
    
    [self refreshColorCircle];
}

- (IBAction)changeColorBlueCircleAction:(UISlider *)sender {
    
    [self changeColorChannel:self.colorBlueLabel
              colorSizeLabel:self.colorBlueSizeLabel
              andColorSlider:self.colorBlueSlider];
    
    [self refreshColorCircle];
    
}

- (IBAction)startMoveCircleAction:(UISwitch *)sender {
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if([[UIApplication sharedApplication] isIgnoringInteractionEvents]){
            
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
        
    });
    
    if(self.startSwitch.isOn){
        
        [self rotationView:self.largeCircleView rotationAngle:-3.14];
        [self rotationView:self.middleCircleView rotationAngle:3.14];
        [self rotationView:self.smallCircleView rotationAngle:-3.14];
        
        self.startLabel.text = @"Stop";
        
    }
    else{
        
        self.startLabel.text = @"Start";
        
    }
}

- (IBAction)visibleAnyControlsAction:(UISwitch *)sender {
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if([[UIApplication sharedApplication] isIgnoringInteractionEvents]){
            
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
        
    });
    
    if(!self.visibleSwitch.isOn){
        
        self.choiceCircleSegmentedControl.hidden = YES;
        
        self.scaleLabel.hidden = YES;
        self.scaleSizeLabel.hidden = YES;
        self.scaleSlider.hidden = YES;
        
        self.speedLabel.hidden = YES;
        self.speedSizeLabel.hidden = YES;
        self.speedSlider.hidden = YES;
        
        self.colorLabel.hidden = YES;
        
        self.colorRedLabel.hidden = YES;
        self.colorRedSizeLabel.hidden = YES;
        self.colorRedSlider.hidden = YES;
        
        self.colorGreenLabel.hidden = YES;
        self.colorGreenSizeLabel.hidden = YES;
        self.colorGreenSlider.hidden = YES;
        
        self.colorBlueLabel.hidden = YES;
        self.colorBlueSizeLabel.hidden = YES;
        self.colorBlueSlider.hidden = YES;
        
        self.startLabel.hidden = YES;
        self.startSwitch.hidden = YES;
        
        self.visibleLabel.text = @"Hide";
        
    }
    else{
        
        self.choiceCircleSegmentedControl.hidden = NO;
        
        self.scaleLabel.hidden = NO;
        self.scaleSizeLabel.hidden = NO;
        self.scaleSlider.hidden = NO;
        
        self.speedLabel.hidden = NO;
        self.speedSizeLabel.hidden = NO;
        self.speedSlider.hidden = NO;
        
        self.colorLabel.hidden = NO;
        
        self.colorRedLabel.hidden = NO;
        self.colorRedSizeLabel.hidden = NO;
        self.colorRedSlider.hidden = NO;
        
        self.colorGreenLabel.hidden = NO;
        self.colorGreenSizeLabel.hidden = NO;
        self.colorGreenSlider.hidden = NO;
        
        self.colorBlueLabel.hidden = NO;
        self.colorBlueSizeLabel.hidden = NO;
        self.colorBlueSlider.hidden = NO;
        
        self.startLabel.hidden = NO;
        self.startSwitch.hidden = NO;
        
        self.visibleLabel.text = @"Visible";
        
    }
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
