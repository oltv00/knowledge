//
//  OTAnimal.m
//  5_Arrays
//
//  Created by Oleg Tverdokhleb on 29.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTAnimal.h"

@implementation OTAnimal

- (instancetype)initWithName:(NSString *) breed Index:(NSInteger)index {
    self = [super init];
    if (self) {
        self.breed = [NSString stringWithFormat:@"%@ #%ld", breed, index];
        self.height = arc4random_uniform(90) + 10;//180.f;
        self.weight = arc4random_uniform(40) + 10;//70.f;
    }
    return self;
}

- (void)move {
    NSLog(@"%@ is move", self);
}

@end
