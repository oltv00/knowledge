//
//  Engine.m
//  Lesson2
//
//  Created by Oleg Tverdokhleb on 30.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "Engine.h"

@implementation Engine

- (void)makeEngine {
    
    [self makeFirstDetail];
    [self makeSecondDetail];
    [self makeThirdDetail];
}

- (void)makeFirstDetail {
    NSLog(@"makeFirstDetaild");
}

- (void)makeSecondDetail {
    NSLog(@"makeSecondDetail");
}

- (void)makeThirdDetail {
    NSLog(@"makeThirdDetail");
}

@end
