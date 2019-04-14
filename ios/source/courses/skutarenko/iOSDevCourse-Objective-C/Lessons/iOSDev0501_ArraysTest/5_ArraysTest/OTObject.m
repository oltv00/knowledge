//
//  OTObject.m
//  5_ArraysTest
//
//  Created by Oleg Tverdokhleb on 29.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTObject.h"

@implementation OTObject

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

- (void)action {
    NSLog(@"%@ ACTION!!!", self.name);
}

@end
