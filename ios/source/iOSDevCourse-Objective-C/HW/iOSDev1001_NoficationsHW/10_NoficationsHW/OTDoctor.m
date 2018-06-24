//
//  OTDoctor.m
//  10_NoficationsHW
//
//  Created by Oleg Tverdokhleb on 03.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTDoctor.h"
#import "OTGovernment.h"

@implementation OTDoctor

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addNotifications];
    }
    return self;
}

#pragma mark - Notification

- (void)addNotifications {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(salaryChangeNotification:)
               name:OTGovernmentSalaryDidChangeNotification
             object:nil];
    
    [nc addObserver:self
           selector:@selector(averagePriceChangeNotification:)
               name:OTGovernmentAveragePriceDidChangeNotification
             object:nil];
}

- (void)salaryChangeNotification:(NSNotification *)notification {
    NSNumber *value = notification.userInfo[OTGovernmentSalaryUserInfoKey];
    CGFloat salary = [value floatValue];
    
    self.salary = salary;
}

- (void)averagePriceChangeNotification:(NSNotification *)notification {

}

@end
