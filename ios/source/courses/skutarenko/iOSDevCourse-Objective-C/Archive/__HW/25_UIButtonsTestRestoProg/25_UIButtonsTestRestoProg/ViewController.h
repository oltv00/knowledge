//
//  ViewController.h
//  25_UIButtonsTestRestoProg
//
//  Created by Oleg Tverdokhleb on 15.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *indicatorLabel;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberOutletOfButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *actionOutletOfButtons;

- (IBAction) numbersButton:(UIButton *)sender;
- (IBAction) actionsButton:(UIButton *)sender;

@end

