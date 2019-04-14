//
//  TTBoard.m
//  UIViewGeometry
//
//  Created by sergey on 2/9/14.
//  Copyright (c) 2014 sergey. All rights reserved.
//

#import "TTBoard.h"

@interface TTBoard ()
@property (nonatomic,strong) NSMutableArray *whiteCheckers;
@property (nonatomic,strong) NSMutableArray *blackCheckers;

@end

@implementation TTBoard

- (UIView *)initBoardWithSize:(CGRect)rect numberOfCells:(NSUInteger)number {

    if (self = [super init]) {
        
        self.whiteCheckers = [[NSMutableArray alloc]init];
        self.blackCheckers = [[NSMutableArray alloc]init];
        
        int width = rect.size.width/number;
        int height = rect.size.height/number;
        int deltaCheckers = 20;
        
        for (int i = 0; i < number; i++) {
            for (int j = 0; j < number; j++) {
                UIView *checkersView = [[UIView alloc]init];
                UIView *view = [[UIView alloc]init];
                if (((i % 2) != 0 && (j % 2) == 0) | ((i % 2) == 0 && (j % 2) != 0)) {
                    [view setBackgroundColor:[UIColor blackColor]];
                    [view setTag:2];
                    
                    if (j < 3) {
                        [checkersView setBackgroundColor:[UIColor grayColor]];
                        [checkersView setTag:4];
                        [self.blackCheckers addObject:checkersView];
                    }
                    if (j > 4) {
                        [checkersView setBackgroundColor:[UIColor blueColor]];
                        [checkersView setTag:5];
                        [self.whiteCheckers addObject:checkersView];
                    }
                    
                } else {
                    [view setBackgroundColor:[UIColor whiteColor]];
                    [view setTag:1];
                }
                view.frame = CGRectMake(i*width, j*height, width, height);
                checkersView.frame = CGRectMake(i*width + deltaCheckers/2, j*height + deltaCheckers/2, width - deltaCheckers, height - deltaCheckers);
                [self addSubview:view];
                [self addSubview:checkersView];
            }
        }
        self.backgroundColor = [UIColor clearColor];
        self.frame = rect;
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    
    return self;
}

- (void)changeColorBoardWithOrientation:(UIInterfaceOrientation)orientation {
    
    if(orientation == UIDeviceOrientationPortrait) {
         [self changeColor:[UIColor blackColor]];
    } else if(orientation == UIDeviceOrientationPortraitUpsideDown) {
        [self changeColor:[UIColor yellowColor]];
    } else if(orientation == UIDeviceOrientationLandscapeLeft) {
        [self changeColor:[UIColor redColor]];
    } else if(orientation == UIDeviceOrientationLandscapeRight) {
        [self changeColor:[UIColor greenColor]];
    }
    
}

- (void)randomSwapCheckers {
    
    
        [UIView animateWithDuration:3.0 animations:^{
            
            CGRect whiteRect = CGRectZero;
            CGRect blackRect = CGRectZero;
            
            for (int i = 0; i < 12; i++) {
                UIView *white = [self.whiteCheckers objectAtIndex:arc4random_uniform(12)];
                UIView *black = [self.blackCheckers objectAtIndex:arc4random_uniform(12)];
                
                whiteRect = white.frame;
                blackRect = black.frame;

                [self bringSubviewToFront:black];
                black.frame = whiteRect;
                [self bringSubviewToFront:white];
                white.frame = blackRect;
            }
        }];
    
}

- (void)changeColor:(UIColor *)color {

            [UIView animateWithDuration:1.0 animations:^{
                for (UIView *view in [self subviews]) {
                    if (view.tag == 2) {
                        [view setBackgroundColor:color];
                        
                    }
                }
            } completion:^(BOOL finished) {
                
            }];

    [self randomSwapCheckers];
}


@end
