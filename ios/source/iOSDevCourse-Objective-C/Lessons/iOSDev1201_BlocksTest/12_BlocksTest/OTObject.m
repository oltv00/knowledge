//
//  OTObject.m
//  12_BlocksTest
//
//  Created by Oleg Tverdokhleb on 05.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTObject.h"

@interface OTObject ()

@property (copy, nonatomic) ObjectBlock objectBlock;

@end

@implementation OTObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak OTObject *weakSelf = self;
        self.objectBlock = ^{
            NSLog(@"%@", weakSelf.name);
        };
    }
    return self;
}

- (void)method:(ObjectBlock)block {
    block();
}

- (void)dealloc {
    NSLog(@"%@ is deallocated", self);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", self.name];
}

@end
