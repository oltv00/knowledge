//
//  MRQSwimmer.m
//  5_ArraysTestRestoProg
//
//  Created by Oleg Tverdokhleb on 01.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQSwimmer.h"

@implementation MRQSwimmer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.gender = arc4random() % 2;
        self.theScopeOfPractice = @"Swimmer";
        
        if (self.gender == man)
            self.name = @"Larry";
        else
            self.name = @"Lucy";
        
        self.height = 180;
        self.weight = 82.68;
        
    }
    return self;
}

- (void) movement{
    [super movement];
    NSLog(@"%@ is move!", self.name);
}

@end
