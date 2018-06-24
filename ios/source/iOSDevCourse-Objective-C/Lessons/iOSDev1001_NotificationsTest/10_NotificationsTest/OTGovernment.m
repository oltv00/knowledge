//
//  OTGovernment.m
//  10_NotificationsTest
//
//  Created by Oleg Tverdokhleb on 02.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTGovernment.h"

NSString *const OTGovernmentTaxLevelDidChangeNotification = @"OTGovernmentTaxLevelDidChangeNotification";
NSString *const OTGovernmentSalaryDidChangeNotification = @"OTGovernmentSalaryDidChangeNotification";
NSString *const OTGovernmentPensionDidChangeNotification = @"OTGovernmentPensionDidChangeNotification";
NSString *const OTGovernmentAveragePriceDidChangeNotification = @"OTGovernmentAveragePriceDidChangeNotification";

NSString *const OTGovernmentTaxLevelUserInfoKey = @"OTGovernmentTaxLevelUserInfoKey";
NSString *const OTGovernmentSalaryUserInfoKey = @"OTGovernmentSalaryUserInfoKey";
NSString *const OTGovernmentPensionUserInfoKey = @"OTGovernmentPensionUserInfoKey";
NSString *const OTGovernmentAveragePriceUserInfoKey = @"OTGovernmentAveragePriceUserInfoKey";


@implementation OTGovernment

- (instancetype)init {
    self = [super init];
    if (self) {
        _taxLevel = 5.f;
        _salary = 1000.f;
        _pension = 500.f;
        _averagePrice = 10.f;
    }
    return self;
}
- (void)setTaxLevel:(CGFloat)taxLevel {
    _taxLevel = taxLevel;
    NSDictionary *userInfo = @{OTGovernmentTaxLevelUserInfoKey : @(taxLevel)};
    [[NSNotificationCenter defaultCenter] postNotificationName:OTGovernmentTaxLevelDidChangeNotification
                                                        object:self
                                                      userInfo:userInfo];
}

- (void)setSalary:(CGFloat)salary {
    _salary = salary;
    NSDictionary *userInfo = @{OTGovernmentSalaryUserInfoKey : @(salary)};
    [[NSNotificationCenter defaultCenter] postNotificationName:OTGovernmentSalaryDidChangeNotification
                                                        object:self
                                                      userInfo:userInfo];
}

-  (void)setPension:(CGFloat)pension {
    _pension = pension;
    NSDictionary *userInfo = @{OTGovernmentPensionUserInfoKey : @(pension)};
    [[NSNotificationCenter defaultCenter] postNotificationName:OTGovernmentPensionDidChangeNotification
                                                        object:self
                                                      userInfo:userInfo];
}

- (void)setAveragePrice:(CGFloat)averagePrice {
    _averagePrice = averagePrice;
    NSDictionary *userInfo = @{OTGovernmentAveragePriceUserInfoKey : @(averagePrice)};
    [[NSNotificationCenter defaultCenter] postNotificationName:OTGovernmentAveragePriceDidChangeNotification
                                                        object:nil
                                                      userInfo:userInfo];
}

@end
