//
//  MRQParrots.m
//  5_ArraysTestRestoProg
//
//  Created by Oleg Tverdokhleb on 01.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQParrots.h"

@implementation MRQParrots

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.subClass = @"Parrots";
        self.name = @"Abrasha";
        self.height = 0.1f;
        self.weight = 0.2f;
    }
    return self;
}

- (void) movement {
    NSLog(@"%@ is move!", self.subClass);
}

@end
