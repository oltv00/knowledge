//
//  OTSwimmer.m
//  5_Arrays
//
//  Created by Oleg Tverdokhleb on 29.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTSwimmer.h"

@implementation OTSwimmer

- (instancetype)initWithName:(NSString *) name Index:(NSInteger)index {
    self = [super initWithName:name Index:index];
    if (self) {
        self.lastName = [NSString stringWithFormat:@"lstrnm %ld", index];
        self.speedOfSwimming = arc4random_uniform(8) + 2;
        self.canRun = arc4random() % 2;
        self.canJump = arc4random() % 2;
    }
    return self;
}

- (void)move {
    [super move];
    NSLog(@"%@ is swims", self);
}

- (void)about {
    [super about];
    NSLog(@"Lastname = %@", self.lastName);
    NSLog(@"Speed of Swimming = %ld", self.speedOfSwimming);
}

#pragma mark - OTSwimmersProtocol

- (void)swim {
    NSLog(@"%@ is swimming %ld", self.name, self.speedOfSwimming);
}

- (void)run {
    NSLog(@"%@ is running", self.name);
}

- (void)jump {
    NSLog(@"%@ is jumping", self.name);
}

@end
