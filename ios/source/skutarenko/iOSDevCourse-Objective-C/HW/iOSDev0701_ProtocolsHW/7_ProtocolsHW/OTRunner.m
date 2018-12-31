//
//  OTRunner.m
//  5_Arrays
//
//  Created by Oleg Tverdokhleb on 29.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTRunner.h"

@implementation OTRunner

- (instancetype)initWithName:(NSString *) name Index:(NSInteger)index {
    self = [super initWithName:name Index:index];
    if (self) {
        self.lastName = [NSString stringWithFormat:@"lstrnm %ld", index];
        self.speedRun = arc4random_uniform(25) + 5;
    }
    return self;
}

- (void)move {
    [super move];
    NSLog(@"%@ is runs", self);
}

- (void)about {
    [super about];
    NSLog(@"Lastname = %@", self.lastName);
    NSLog(@"Speedrun = %ld", self.speedRun);
}

#pragma mark - OTRunnersProtocol

- (void)run {
    NSLog(@"%@ is running %ld", self.name, self.speedRun);
}

@end
