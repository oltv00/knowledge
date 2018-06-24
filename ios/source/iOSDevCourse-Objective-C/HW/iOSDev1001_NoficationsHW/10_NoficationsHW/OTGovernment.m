//
//  OTGovernment.m
//  10_NoficationsHW
//
//  Created by Oleg Tverdokhleb on 03.04.16.
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
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    NSDictionary *userInfo = @{ OTGovernmentTaxLevelUserInfoKey : @(taxLevel) };
    [nc postNotificationName:OTGovernmentTaxLevelDidChangeNotification
                      object:nil
                    userInfo:userInfo];
}

- (void)setSalary:(CGFloat)salary {
    _salary = salary;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    NSDictionary *userInfo = @{ OTGovernmentSalaryUserInfoKey : @(salary) };
    [nc postNotificationName:OTGovernmentSalaryDidChangeNotification
                      object:nil
                    userInfo:userInfo];

}

- (void)setPension:(CGFloat)pension {
    _pension = pension;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    NSDictionary *userInfo = @{ OTGovernmentPensionUserInfoKey : @(pension) };
    [nc postNotificationName:OTGovernmentPensionDidChangeNotification
                      object:nil
                    userInfo:userInfo];
}

- (void)setAveragePrice:(CGFloat)averagePrice {
    _averagePrice = averagePrice;
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    NSDictionary *userInfo = @{ OTGovernmentAveragePriceUserInfoKey : @(averagePrice) };
    [nc postNotificationName:OTGovernmentAveragePriceDidChangeNotification
                      object:nil
                    userInfo:userInfo];
}

@end
