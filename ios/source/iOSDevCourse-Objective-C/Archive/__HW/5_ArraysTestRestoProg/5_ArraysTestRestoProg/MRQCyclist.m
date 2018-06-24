//
//  MRQCyclist.m
//  5_ArraysTestRestoProg
//
//  Created by Oleg Tverdokhleb on 01.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQCyclist.h"

@implementation MRQCyclist

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.gender = arc4random() % 2;
        self.theScopeOfPractice = @"Cyclist";
        
        if (self.gender == man)
            self.name = @"Johny";
        else
            self.name = @"Kate";
        
        self.height = 170;
        self.weight = 72.84;
    }
    return self;
}

- (void) movement{
    [super movement];
    NSLog(@"%@ is move!", self.name);
}

@end
