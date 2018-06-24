//
//  MRQBoxer.m
//  2_PropertiesTest
//
//  Created by Oleg Tverdokhleb on 04.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQBoxer.h"

@interface MRQBoxer ()
@property (nonatomic, assign) NSInteger nameCount;
@end

@implementation MRQBoxer
@synthesize name = _name;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _nameCount = 0;
        _name = @"Default";
        _age = 0;
        self.height = 0;
        self.weight = 0;
    }
    return self;
}

- (void) setName:(NSString *)name {
    NSLog(@"Setter setName: is called");
    _name = name;
}

- (NSString*) name {
    self.nameCount++;
    NSLog(@"Name getter is called %ld times", (long)self.nameCount);
    return _name;
}

- (NSInteger) age {
    NSLog(@"Age getter is called");
    return _age;
}

- (NSInteger*) howOldAreYou{
    return _age;
}

@end
