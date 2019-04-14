//
//  OTStudent.m
//  12_BlocksHW
//
//  Created by Oleg Tverdokhleb on 06.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTStudent.h"
#import "Data.h"

@implementation OTStudent

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = firstNames[arc4random_uniform(50)];
        self.lastName = lastNames[arc4random_uniform(50)];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%@ is deallocated", self);
}

@end
