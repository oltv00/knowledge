//
//  OTDoctor.m
//  10_NotificationsTest
//
//  Created by Oleg Tverdokhleb on 03.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTDoctor.h"
#import "OTGovernment.h"

@implementation OTDoctor

#pragma mark - LifeCycle

- (instancetype)init {
    self = [super init];
    if (self) {
        _salary = 500;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(salaryChangedNotification:)
                                                     name:OTGovernmentSalaryDidChangeNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(averagePriceChangedNotification:)
                                                     name:OTGovernmentAveragePriceDidChangeNotification
                                                   object:nil];
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification

- (void)salaryChangedNotification:(NSNotification *)notification {
    NSNumber *value = notification.userInfo[OTGovernmentSalaryUserInfoKey];
    CGFloat salary = [value floatValue];
    if (salary < self.salary) {
        NSLog(@"Doctors are not happy");
    } else {
        NSLog(@"Doctors are happy");
    }
    self.salary = salary;
}

- (void)averagePriceChangedNotification:(NSNotification *)notification {
    
}

@end
