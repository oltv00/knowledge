//
//  MRQHuman.m
//  5_ArraysTestRestoProg
//
//  Created by Oleg Tverdokhleb on 01.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQHuman.h"


@implementation MRQHuman

- (void) movement{
    NSLog(@"%@ SUPER MOVEMENT!", self.name);
}

- (void) conclusion {
    
    NSLog(@"This object class %@", self);
    NSLog(@"Scope of Practice: %@", self.theScopeOfPractice);
    NSLog(@"Name: %@", self.name);
    NSLog(@"Height: %.0f", self.height);
    NSLog(@"Weight: %.2f", self.weight);
    
    if (self.gender == man)
        NSLog(@"Gender is: Man");
    else
        NSLog(@"Gender is: Woman");
    
    [self movement];
    
    NSLog(@"\n");
}

@end
