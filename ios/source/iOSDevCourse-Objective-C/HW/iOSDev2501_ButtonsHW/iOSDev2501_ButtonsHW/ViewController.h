//
//  ViewController.h
//  iOSDev2501_ButtonsHW
//
//  Created by Oleg Tverdokhleb on 22.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *displayResultLabel;

- (IBAction)actionNumberPressed:(UIButton *)sender;
- (IBAction)actionClearButtonPressed:(UIButton *)sender;
- (IBAction)actionTwoOperandsSignPressed:(UIButton *)sender;
- (IBAction)actionEqalitySignPressed:(UIButton *)sender;
- (IBAction)actionPlusMinusButtonPressed:(UIButton *)sender;
- (IBAction)actionPercentageButtonPressed:(UIButton *)sender;
- (IBAction)actionSquareButtonPressed:(UIButton *)sender;
- (IBAction)actionDotButtonPressed:(UIButton *)sender;

@end

