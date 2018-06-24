//
//  MRQRunner.m
//  5_ArraysTestRestoProg
//
//  Created by Oleg Tverdokhleb on 01.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQRunner.h"

@implementation MRQRunner

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.gender = arc4random() % 2;
        self.theScopeOfPractice = @"Runner";
        
        if (self.gender == man)
            self.name = @"Matt";
        else
            self.name = @"Rebecca";
        
        self.height = 175;
        self.weight = 77.26;
        
    }
    return self;
}

- (void) movement{
    [super movement];
    NSLog(@"%@ is move!", self.name);
}

@end
