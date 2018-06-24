//
//  EngineBMW.m
//  Lesson2
//
//  Created by Oleg Tverdokhleb on 30.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "EngineBMW.h"

@implementation EngineBMW

- (void)makeEngine {
    
    [self makeFirstDetail];
    [self makeSecondDetail];
    [self makeThirdDetail];
}

- (void)makeSecondDetail {
    NSLog(@"BMW_makeSecondDetail");
}

- (void)makeThirdDetail {
    NSLog(@"BMW_makeThirdDetail");
}

@end
