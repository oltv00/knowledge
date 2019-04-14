//
//  MRQDoctor.m
//  10_NotificationsTest
//
//  Created by Oleg Tverdokhleb on 21.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQDoctor.h"
#import "MRQGovernment.h"
@implementation MRQDoctor




#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(salaryChangedNotification:)
                                                     name:MRQGovernmentSalaryDidChangeNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(averagePriceChangedNotification:)
                                                     name:MRQGovernmentAveragePriceDidChangeNotification
                                                   object:nil];
    }
    return self;
}



- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void) salaryChangedNotification:(NSNotification*) notification {
    
    NSNumber* value = [notification.userInfo objectForKey:MRQGovernmentSalaryUserInfoKey];
    
    CGFloat salary = [value floatValue];
    
    if (salary < self.salary) {
        NSLog(@"Doctors are not happy!");
    } else {
        NSLog(@"Doctors are happy!");
    }
    
    self.salary = salary;
}

- (void) averagePriceChangedNotification:(NSNotification*) notification {
    
    
    
}

@end
