//
//  StoryboardViewController.m
//  Lesson3
//
//  Created by Oleg Tverdokhleb on 20.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "StoryboardViewController.h"

@interface StoryboardViewController ()

@property (weak, nonatomic) IBOutlet UIView *mainView;

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender;

@end

@implementation StoryboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.view];
    NSLog(@"%@", NSStringFromCGPoint(point));
    _mainView.center = point;
}
@end
