//
//  MRQObject.m
//  12_BlocksTest
//
//  Created by Oleg Tverdokhleb on 24.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQObject.h"

@interface MRQObject ()

@property (strong, nonatomic) ObjectBlock objectBlock;

@end

@implementation MRQObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        __weak MRQObject *weakSelf = self;
        
        self.objectBlock = ^{
            NSLog(@"%@", self.name); //Т.о. объект будет существовать ВСЕГДА!!!
        };

        self.objectBlock = ^{
            NSLog(@"%@", weakSelf.name); // Так он уничтожится.
        };
    }
    return self;
}

- (void) testMethod:(ObjectBlock) block {
    block();
}

- (void) dealloc {
    NSLog(@"MRQObject is deallocated");
}

@end
