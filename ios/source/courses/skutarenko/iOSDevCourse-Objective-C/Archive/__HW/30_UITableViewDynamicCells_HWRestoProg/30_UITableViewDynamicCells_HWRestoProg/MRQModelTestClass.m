//
//  MRQModelTestClass.m
//  30_UITableViewDynamicCells_HWRestoProg
//
//  Created by Oleg Tverdokhleb on 28.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQModelTestClass.h"

static NSInteger varIndex = 0;

@implementation MRQModelTestClass

- (instancetype)init
{
    self = [super init];
    if (self) {
        _name = @"name";
        _index = ++varIndex;
    }
    return self;
}

@end
