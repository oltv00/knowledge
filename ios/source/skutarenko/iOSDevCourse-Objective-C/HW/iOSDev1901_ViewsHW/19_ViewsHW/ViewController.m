
//  ViewController.m
//  19_ViewsHW
//
//  Created by Oleg Tverdokhleb on 10.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIView *chessBoard;
@property (strong, nonatomic) NSMutableArray *arrayOfBlackCells;
@property (strong, nonatomic) NSMutableArray *arrayOfTopCheckers;
@property (strong, nonatomic) NSMutableArray *arrayOfBottomCheckers;

@end

@implementation ViewController

#pragma mark - LoadCycles

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initProperties];
    [self createChessBoard];
    [self createCells];
    [self createCheckers];
}

- (void)initProperties {
    self.arrayOfBlackCells = [NSMutableArray array];
    self.arrayOfTopCheckers = [NSMutableArray array];
    self.arrayOfBottomCheckers = [NSMutableArray array];
}

- (void)createChessBoard {
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = width;
    CGRect chessBoardRect = CGRectMake(x, y, width, height);
    UIView *chessBoardView = [[UIView alloc] initWithFrame:chessBoardRect];
    chessBoardView.backgroundColor = [UIColor redColor];
    chessBoardView.center = self.view.center;
    chessBoardView.autoresizingMask =   UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |
                                        UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:chessBoardView];
    self.chessBoard = chessBoardView;
}

- (void)createCells {
    CGFloat cellSize = CGRectGetWidth(self.view.frame) / 8;
    
    for (int string = 0; string < 8; string += 1) {
        for (int column = 0; column < 8; column += 1) {
            CGFloat x = column * cellSize;
            CGFloat y = string * cellSize;
            CGRect cellRect = CGRectMake(x, y, cellSize, cellSize);
            UIView *cellView = [[UIView alloc] initWithFrame:cellRect];
            cellView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
            
            if ((string % 2 == 0 && column % 2 == 0) || (string % 2 != 0 && column % 2 != 0)) {
                //white
                cellView.backgroundColor = [UIColor whiteColor];
                [self.chessBoard addSubview:cellView];
            } else {
                //black
                cellView.backgroundColor = [UIColor blackColor];
                [self.chessBoard addSubview:cellView];
                [self.arrayOfBlackCells addObject:cellView];
            }
        }
    }
}

- (void)createCheckers {
    CGFloat checkerSize = CGRectGetWidth(self.view.frame) / 8;

    for (int string = 0; string < 8; string += 1) {
        for (int column = 0; column < 8; column += 1) {
            CGFloat x = column * checkerSize;
            CGFloat y = string * checkerSize;
            CGRect checkerRect = CGRectMake(x, y, checkerSize, checkerSize);
            UIView *checkerView = [[UIView alloc] initWithFrame:checkerRect];
            checkerView.layer.cornerRadius = checkerSize / 2;
            
            if (!((string % 2 == 0 && column % 2 == 0) || (string % 2 != 0 && column % 2 != 0))) {
                if (string < 3) {
                    //top checkers
                    checkerView.backgroundColor = [UIColor blueColor];
                    [self.arrayOfTopCheckers addObject:checkerView];
                } else if (string > 4) {
                    //bottom checkers
                    checkerView.backgroundColor = [UIColor redColor];
                    [self.arrayOfBottomCheckers addObject:checkerView];
                }
                [self.chessBoard addSubview:checkerView];
            }
        }
    }
}

#pragma mark - Additional methods

- (UIColor *)randomColor {
    CGFloat r = (CGFloat)arc4random_uniform(256) / 255;
    CGFloat g = (CGFloat)arc4random_uniform(256) / 255;
    CGFloat b = (CGFloat)arc4random_uniform(256) / 255;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}

- (void)mixCheckers {
    [UIView animateWithDuration:2 animations:^{
        for (int i = 0; i < 12; i += 1) {
            UIView *topChecker = self.arrayOfTopCheckers[arc4random_uniform(12)];
            UIView *bottomChecker = self.arrayOfBottomCheckers[arc4random_uniform(12)];
            
            CGRect rectTopChecker = topChecker.frame;
            CGRect rectBottomChecker = bottomChecker.frame;
            CGRect tempRect = CGRectZero;
            
            tempRect = rectTopChecker;
            rectTopChecker = rectBottomChecker;
            rectBottomChecker = tempRect;
            
            topChecker.frame = rectTopChecker;
            bottomChecker.frame = rectBottomChecker;
        }
    }];
}

#pragma mark - UIViewControllerRotation

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    UIColor *randomColor = [self randomColor];
    for (UIView *view in self.arrayOfBlackCells) {
        view.backgroundColor = randomColor;
    }
    [self mixCheckers];
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - __UNUSED__

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
