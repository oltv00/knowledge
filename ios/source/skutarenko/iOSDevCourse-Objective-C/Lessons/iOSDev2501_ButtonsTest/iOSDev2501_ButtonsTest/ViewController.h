//
//  ViewController.h
//  iOSDev2501_ButtonsTest
//
//  Created by Oleg Tverdokhleb on 21.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelNumbers;

- (IBAction)actionCalc:(UIButton *)sender;
- (IBAction)actionTest3:(UIButton *)sender;
- (IBAction)actionTest3TouchDown:(UIButton *)sender;
- (IBAction)actionButtonTest4:(UIButton *)sender;

@end

