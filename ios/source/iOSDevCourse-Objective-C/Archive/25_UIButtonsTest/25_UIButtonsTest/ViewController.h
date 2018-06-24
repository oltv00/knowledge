//
//  ViewController.h
//  25_UIButtonsTest
//
//  Created by Oleg Tverdokhleb on 15.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (weak, nonatomic) IBOutlet UILabel *indicatorLabel;

- (IBAction) actionButtonTestInside:(UIButton *) sender;
- (IBAction) actionButtonTestOutsied:(UIButton *) sender;

@end

