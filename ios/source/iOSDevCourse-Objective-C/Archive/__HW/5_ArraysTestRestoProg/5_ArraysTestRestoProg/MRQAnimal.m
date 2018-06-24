//
//  MRQAnimal.m
//  5_ArraysTestRestoProg
//
//  Created by Oleg Tverdokhleb on 01.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQAnimal.h"


@implementation MRQAnimal

- (void) movement {
    NSLog(@"%@ SUPER MOVE!", self.subClass);
}

- (void) conclusion {
    
    NSLog(@"This object class %@", self);
    NSLog(@"Subclass of Animals %@", self.subClass);
    NSLog(@"Name: %@", self.name);
    NSLog(@"Height: %.2f", self.height);
    NSLog(@"Weight: %.2f", self.weight);
    
    [self movement];
    
    NSLog(@"\n");
}

@end
