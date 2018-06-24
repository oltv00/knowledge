//
//  MRQBoxer.m
//  3_PropertiesTest
//
//  Created by Oleg Tverdokhleb on 02.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQBoxer.h"

@interface MRQBoxer ()
@property (assign, nonatomic) NSInteger nameCount;
@end

@implementation MRQBoxer

@synthesize name = _name;

- (instancetype)initWithDefaultParameters {
    self = [super init];
    if (self) {
        _name = @"defaultName";
        _age = 0;
        _height = 0;
        _weight = 0;
        _nameCount = 0;
    }
    return self;
}

- (void)setName:(NSString *)name {
    NSLog(@"setter setName: is called");
    _name = name;
}

- (NSString *)name {
    self.nameCount += 1;
    NSLog(@"name getter is called %ld times", self.nameCount);
    return _name;
}

- (NSInteger)age {
    NSLog(@"getter age: is called");
    return _age;
}

- (NSInteger)howOldAreYouWithGetter {
    return self.age;
}

- (NSInteger)howOldAreYouWithoutGetter {
    return _age;
}

@end
