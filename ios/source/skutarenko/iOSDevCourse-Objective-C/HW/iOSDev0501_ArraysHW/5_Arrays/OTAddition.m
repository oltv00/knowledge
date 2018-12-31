//
//  OTAddition.m
//  5_Arrays
//
//  Created by Oleg Tverdokhleb on 29.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTAddition.h"

@implementation OTAddition

- (instancetype)initWithName:(NSString *)name Index:(NSInteger)index {
    self = [super initWithName:name Index:index];
    if (self) {
        self.age = arc4random_uniform(40) + 21;
        self.lastName = [NSString stringWithFormat:@"Lastname #%ld", index];
        self.education = [NSString stringWithFormat:@"Education #%ld", index];
    }
    return self;
}

- (void)aboutAddition {
    NSLog(@"Lastname = %@", self.lastName);
    NSLog(@"Education = %@", self.education);
    NSLog(@"Age = %ld", self.age);
}

@end
