//
//  MRQDogs.m
//  5_ArraysTestRestoProg
//
//  Created by Oleg Tverdokhleb on 01.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQDogs.h"

@implementation MRQDogs

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.subClass = @"Dogs";
        self.name = @"Sharik";
        self.height = 0.4f;
        self.weight = 2.3f;
    }
    return self;
}

- (void) movement {
    NSLog(@"%@ is move!", self.subClass);
}

@end
