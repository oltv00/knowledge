//
//  ViewController.m
//  Lesson1
//
//  Created by Oleg Tverdokhleb on 29.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import "Auto.h"

@interface ViewController ()

@property (strong, nonatomic) Auto *auto1;
@property (weak, nonatomic) IBOutlet UILabel *directionLabel;

- (IBAction)actionLeft:(id)sender;
- (IBAction)actionRight:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    Auto *auto1 = [[Auto alloc] init];
    self.auto1 = auto1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionLeft:(id)sender {
    [self.auto1 driveAuto:AutoDirectionLeft];
    [self animatedVisible];
}

- (IBAction)actionRight:(id)sender {
    [self.auto1 driveAuto:AutoDirectionRight];
    [self animatedVisible];
}

- (void) animatedVisible {
    
    __weak UILabel *weakDirection = self.directionLabel;
    
    weakDirection.text = self.auto1.direction;
    weakDirection.alpha = 0.f;
    
    [UIView animateWithDuration:1.f
                     animations:^{
                         
                         weakDirection.alpha = 1.f;
                         
                     }];
}

@end
