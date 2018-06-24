//
//  Auto.m
//  Lesson5HW
//
//  Created by Oleg Tverdokhleb on 06.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "Auto.h"

@implementation Auto

+ (Auto *) initialize {
    Auto *obj = [[Auto alloc] init];
    return obj;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _model = models[arc4random_uniform(14)];
        _engine = engines[arc4random_uniform(14)];
    }
    return self;
}

static NSString* models[] = {
    @"BMW", @"Mercedes", @"Audi", @"Ford", @"Volkswagen",
    @"Honda", @"Kia", @"Mazda", @"Nissan", @"Toyota",
    @"Acura", @"Lexus", @"Skoda", @"Subaru", @"GMC"
};

static NSString* engines[] = {
    @"1.0", @"1.2", @"1.4", @"1.6", @"1.8",
    @"2.0", @"2.2", @"2.4", @"2.6", @"2.8",
    @"3.0", @"3.2", @"3.4", @"3.6", @"3.8"
};

@end
