//
//  MRQJumper.m
//  5_ArraysTestRestoProg
//
//  Created by Oleg Tverdokhleb on 01.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQJumper.h"

@implementation MRQJumper

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.gender = arc4random() % 2;
        self.theScopeOfPractice = @"Jumper";
        
        if (self.gender == man)
            self.name = @"Edmond";
        else
            self.name = @"Rachel";
        
        self.height = 160;
        self.weight = 69.84;
    }
    return self;
}

- (void) movement{
    [super movement];
    NSLog(@"%@ is move!", self.name);
}

@end
