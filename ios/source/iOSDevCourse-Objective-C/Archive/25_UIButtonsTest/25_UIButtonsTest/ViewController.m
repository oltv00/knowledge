//
//  ViewController.m
//  25_UIButtonsTest
//
//  Created by Oleg Tverdokhleb on 15.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(200, 200, 200, 200);
    button.backgroundColor = [UIColor lightGrayColor];
    button = [self buttonWithCustomSettings:button];
    [button addTarget:self action:@selector(actionTestInside:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(actionTestOutside:) forControlEvents:UIControlEventTouchUpOutside];
    //[self.view addSubview:button];
    /*
    UIKIT_EXTERN NSString * const NSFontAttributeName NS_AVAILABLE(10_0, 6_0);                // UIFont, default Helvetica(Neue) 12
    UIKIT_EXTERN NSString * const NSParagraphStyleAttributeName NS_AVAILABLE(10_0, 6_0);      // NSParagraphStyle, default defaultParagraphStyle
    UIKIT_EXTERN NSString * const NSForegroundColorAttributeName NS_AVAILABLE(10_0, 6_0);     // UIColor, default blackColor
    UIKIT_EXTERN NSString * const NSBackgroundColorAttributeName NS_AVAILABLE(10_0, 6_0);     // UIColor, default nil: no background
    UIKIT_EXTERN NSString * const NSLigatureAttributeName NS_AVAILABLE(10_0, 6_0);
    */
    
    
    
    
    
    
}

#pragma mark - Actions

- (void) actionTestInside:(UIButton *) button {
    NSLog(@"Button Pressed Inside");
}

- (void) actionTestOutside:(UIButton *) button {
    NSLog(@"Button Pressed Outside");
}

- (IBAction) actionButtonTestInside:(UIButton *) sender {
    NSLog(@"actionButtonTestInside tag: %ld", sender.tag);
    
    self.indicatorLabel.text = [NSString stringWithFormat:@"%ld", sender.tag];
    
    for (UIButton *button in self.buttons) {
        if ([button isEqual:sender]) {
            NSLog(@"IBOutletCollection INSIDE tag: %ld", sender.tag);
        }
    }
}

- (IBAction) actionButtonTestOutsied:(UIButton *) sender {
    NSLog(@"actionButtonTestOutsied tag: %ld", sender.tag);
    
    for (UIButton *button in self.buttons) {
        if ([button isEqual:sender]) {
            NSLog(@"IBOutletCollection OUTSIDE tag: %ld", sender.tag);
        }
    }
}

#pragma mark - Button Setups

- (UIButton *) buttonWithCustomSettings:(UIButton *) button {
    
    [button setTitle:@"Button" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [button setTitle:@"Button Pressed" forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(100, 100, 0, 0);
    button.titleEdgeInsets = insets;
    
    //Для того чтобы сдвинуть место где вставляеются "..." если title не помещается,
    //нужно использовать paragraph style

    return button;
}

- (UIButton *) NSAttributedString:(UIButton *) button {
    NSDictionary *attributesButton = @{NSFontAttributeName : [UIFont systemFontOfSize:30],
                                       NSForegroundColorAttributeName : [UIColor orangeColor]};
    NSDictionary *attributesPressedButton = @{NSFontAttributeName : [UIFont systemFontOfSize:20],
                                              NSForegroundColorAttributeName : [UIColor redColor]};
    
    NSAttributedString *titleButton = [[NSAttributedString alloc] initWithString:@"Button" attributes:attributesButton];
    NSAttributedString *titlePressedButton = [[NSAttributedString alloc] initWithString:@"Button Pressed" attributes:attributesPressedButton];
    
    [button setAttributedTitle:titleButton forState:UIControlStateNormal];
    [button setAttributedTitle:titlePressedButton forState:UIControlStateHighlighted];
    
    return button;
}

@end
