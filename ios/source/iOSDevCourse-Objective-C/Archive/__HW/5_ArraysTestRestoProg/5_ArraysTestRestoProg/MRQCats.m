//
//  MRQCats.m
//  5_ArraysTestRestoProg
//
//  Created by Oleg Tverdokhleb on 01.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQCats.h"

@implementation MRQCats

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.subClass = @"Cats";
        self.name = @"Loorraaaaa";
        self.height = 0.2f;
        self.weight = 1.3f;
    }
    return self;
}

- (void) movement {
    NSLog(@"%@ is move!", self.subClass);
}

@end
