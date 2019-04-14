//
//  ViewController.m
//  19_ViewsTestRestoProg
//
//  Created by Oleg Tverdokhleb on 26.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIView *boardView;
@property (strong, nonatomic) NSMutableArray *blackViewArray;
@property (strong, nonatomic) NSMutableArray *upFigureArray;
@property (strong, nonatomic) NSMutableArray *downFigureArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self boardCreate];
}

- (CGRect) boardCreate {
    self.view.backgroundColor = [UIColor grayColor];
    
    CGFloat proportions = self.view.frame.size.width;
    
    UIView *generalView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, proportions, proportions)];
    
    generalView.center = self.view.center;
    
    generalView.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                                    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    generalView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:generalView];
    
    CGRect boardRect = CGRectMake(0, 0, proportions/8, proportions/8);

    self.blackViewArray = [[NSMutableArray alloc] init];
    self.upFigureArray = [[NSMutableArray alloc] init];
    self.downFigureArray = [[NSMutableArray alloc] init];

    
    for (NSInteger string = 0; string < 8; string++) {
        for (NSInteger column = 0; column < 8; column++) {
            if (((string % 2) != 0 && (column % 2) == 0) || ((string % 2) == 0 && (column % 2) != 0)) {
                
                //Creating chess board
                UIView *blackView = [[UIView alloc] initWithFrame:
                                     CGRectMake(CGRectGetWidth(boardRect) * column,
                                                CGRectGetHeight(boardRect) * string,
                                                CGRectGetWidth(boardRect),
                                                CGRectGetHeight(boardRect))];

                
                blackView.backgroundColor = [UIColor blackColor];
                [generalView addSubview:blackView];
                [self.blackViewArray addObject:blackView]; //Add all black view to array
            
                //The creation of chess pieces
                UIView *figure = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(boardRect) * column,
                                                                          CGRectGetHeight(boardRect) * string,
                                                                          proportions/16,
                                                                          proportions/16)];
                
                if (string < 3){
                    figure.layer.cornerRadius = 7.5f;
                    figure.center = blackView.center;
                    figure.backgroundColor = [UIColor greenColor];
                    [generalView addSubview:figure];
                    [self.upFigureArray addObject:figure];

                }
                if (string > 4){
                    figure.layer.cornerRadius = 7.5f;
                    figure.center = blackView.center;
                    figure.backgroundColor = [UIColor redColor];
                    [generalView addSubview:figure];
                    [self.downFigureArray addObject:figure];

                }
            }
            else
            {
                
                UIView *whiteView = [[UIView alloc] initWithFrame:
                                     CGRectMake(CGRectGetWidth(boardRect) * string,
                                                CGRectGetHeight(boardRect) * column,
                                                CGRectGetWidth(boardRect),
                                                CGRectGetHeight(boardRect))];
                
                whiteView.backgroundColor = [UIColor whiteColor];
                [generalView addSubview:whiteView];
            }
        }
    }
    self.boardView = generalView;
    return boardRect;
}

- (UIColor*) randomColor {
    CGFloat r = (float)(arc4random() % 256) /  255;
    CGFloat g = (float)(arc4random() % 256) /  255;
    CGFloat b = (float)(arc4random() % 256) /  255;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

- (void) mixAllFigures {
        
    [UIView animateWithDuration:1.0 animations:^{
        
        CGRect upFigureRect = CGRectZero;
        CGRect downFigureRect = CGRectZero;
        
        for (int i = 0; i < 12; i++) {
            UIView *upFigureView = [self.upFigureArray objectAtIndex:arc4random_uniform(12)];
            UIView *downFigureView = [self.downFigureArray objectAtIndex:arc4random_uniform(12)];
            
            upFigureRect = upFigureView.frame;
            downFigureRect = downFigureView.frame;
            
            [self.boardView bringSubviewToFront:downFigureView];
            downFigureView.frame = upFigureRect;
            
            [self.boardView bringSubviewToFront:upFigureView];
            upFigureView.frame = downFigureRect;
        }
    }];
    
}


- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    UIColor *selectColorWhenRotationChange = [self randomColor];
//
//    [UIView animateWithDuration:0.5 animations:^{
//        for (UIView *view in self.blackViewArray) {
//            view.backgroundColor = selectColorWhenRotationChange;
//        }
//    } completion:^(BOOL finished) {}];
//    
//    [self mixAllFigures];
    
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
