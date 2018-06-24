//
//  ViewController.m
//  iOSDev2501_ButtonsTest
//
//  Created by Oleg Tverdokhleb on 21.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self level1]; //button create
    [self level2]; //atributed string
    [self level3]; //insets
    [self level4]; //add action and events
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionCalc:(UIButton *)sender {
    self.labelNumbers.text = [NSString stringWithFormat:@"%@%ld", self.labelNumbers.text, sender.tag];
    NSLog(@"tag = %ld", sender.tag);
}

- (IBAction)actionButtonTest4:(UIButton *)sender {
    NSLog(@"actionButtonTest4");
}

- (IBAction)actionTest3TouchDown:(UIButton *)sender {
    NSLog(@"actionTest3TouchDown");
}

- (IBAction)actionTest3:(UIButton *)sender {
    NSLog(@"actionTest3");
}

- (void)level4 {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 100, 100, 100);
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"Button" forState:UIControlStateNormal];
    [button setTitle:@"Button Pressed" forState:UIControlStateHighlighted];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(actionTest:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(actionTestOutside:) forControlEvents:UIControlEventTouchUpOutside];
}
- (void)actionTestOutside:(UIButton *)sender {
    NSLog(@"UIControlEventTouchUpOutside");
}
- (void)actionTest:(UIButton *)sender {
    NSLog(@"UIControlEventTouchUpInside");
}

- (void)level3 {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(180, 20, 75, 75);
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"Button" forState:UIControlStateNormal];
    [button setTitle:@"Button Pressed" forState:UIControlStateHighlighted];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(50, 50, 0, 0);
    button.titleEdgeInsets = insets;
    [self.view addSubview:button];
}

- (void)level2 {
    /*
     // Predefined character attributes for text. If the key is not in the dictionary, then use the default values as described below.
     UIKIT_EXTERN NSString * const NSFontAttributeName NS_AVAILABLE(10_0, 6_0);                // UIFont, default Helvetica(Neue) 12
     UIKIT_EXTERN NSString * const NSParagraphStyleAttributeName NS_AVAILABLE(10_0, 6_0);      // NSParagraphStyle, default defaultParagraphStyle
     UIKIT_EXTERN NSString * const NSForegroundColorAttributeName NS_AVAILABLE(10_0, 6_0);     // UIColor, default blackColor
     UIKIT_EXTERN NSString * const NSBackgroundColorAttributeName NS_AVAILABLE(10_0, 6_0);     // UIColor, default nil: no background
     UIKIT_EXTERN NSString * const NSLigatureAttributeName NS_AVAILABLE(10_0, 6_0);
     */
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 20, 75, 75);
    button.backgroundColor = [UIColor lightGrayColor];
    
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:30],
                                 NSForegroundColorAttributeName : [UIColor orangeColor]};
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"Button" attributes:attributes];

    NSDictionary *attributesHighlighted = @{NSFontAttributeName : [UIFont systemFontOfSize:20],
                                 NSForegroundColorAttributeName : [UIColor redColor]};
    NSAttributedString *titleHighlighted = [[NSAttributedString alloc] initWithString:@"Button Pressed" attributes:attributesHighlighted];

    [button setAttributedTitle:title forState:UIControlStateNormal];
    [button setAttributedTitle:titleHighlighted forState:UIControlStateHighlighted];
    
    [self.view addSubview:button];
}

- (void)level1 {
    //button create
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 20, 75, 75);
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"Button" forState:UIControlStateNormal];
    [button setTitle:@"Button Pressed" forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    
    [self.view addSubview:button];
}

@end
