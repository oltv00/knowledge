//
//  TTViewController.m
//  UIViewGeometry
//
//  Created by sergey on 2/8/14.
//  Copyright (c) 2014 sergey. All rights reserved.
//

#import "TTViewController.h"
#import "TTBoard.h"

@interface TTViewController ()

@property (strong,nonatomic) TTBoard *board;

@end

@implementation TTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.board = [[TTBoard alloc]initBoardWithSize:CGRectMake(0, 124, 320, 320) numberOfCells:8];
    
    if (self.board) {
        [self.view addSubview:self.board];
    }
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.board changeColorBoardWithOrientation:toInterfaceOrientation];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
