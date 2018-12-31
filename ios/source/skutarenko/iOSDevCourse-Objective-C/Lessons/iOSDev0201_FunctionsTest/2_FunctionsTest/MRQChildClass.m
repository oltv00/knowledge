//
//  MRQChildClass.m
//  2_FunctionsTest
//
//  Created by Oleg Tverdokhleb on 29.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQChildClass.h"

@implementation MRQChildClass

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"Instance of child class is initialized");
    }
    return self;
}

-(NSString *)saySomething {
    return @"Something";
}

@end
