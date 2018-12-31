//
//  MRQObject.m
//  3_ParametersTest
//
//  Created by Oleg Tverdokhleb on 04.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQObject.h"

@implementation MRQObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@ is created", self);
    }
    return self;
}

- (void) dealloc {
    NSLog(@"%@ is deallocated", self);
}

@end
