//
//  MRQParentClass.m
//  2_FunctionsTest
//
//  Created by Oleg Tverdokhleb on 29.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQParentClass.h"

@implementation MRQParentClass

+ (void)whoAreYou {
    NSLog(@"I'am %@", self);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"Instance of parent class is initialized");
    }
    return self;
}

- (instancetype)initWithName:(NSString *) name {
    self = [super init];
    if (self) {
        NSLog(@"Instance of parent class is initialized");
        _name = name;
    }
    return self;
}

- (void)sayHello {
    NSLog(@"%@ say hello!", self.name);
}

- (void)say:(NSString *) string {
    NSLog(@"%@", string);
}

- (void)sayFirst:(NSString *) first andSecond:(NSString *) second {
    NSLog(@"%@ %@", first, second);
}

- (NSString *)saySomeNumberString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.YYYY HH:mm"];
    NSDate *date = [NSDate date];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

- (NSString *)saySomething {
    NSString *returnString = [self saySomeNumberString];
    return [NSString stringWithFormat:@"NOW IS: %@", returnString];
}

@end
