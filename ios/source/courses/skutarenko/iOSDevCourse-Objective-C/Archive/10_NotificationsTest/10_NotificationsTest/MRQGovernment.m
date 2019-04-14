//
//  MRQGovernment.m
//  10_NotificationsTest
//
//  Created by Oleg Tverdokhleb on 21.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQGovernment.h"

NSString *const MRQGovernmentTaxLevelDidChangeNotification = @"MRQGovernmentTaxLevelDidChangeNotification";
NSString *const MRQGovernmentSalaryDidChangeNotification = @"MRQGovernmentSalaryDidChangeNotification";
NSString *const MRQGovernmentPensionDidChangeNotification = @"MRQGovernmentPensionDidChangeNotification";
NSString *const MRQGovernmentAveragePriceDidChangeNotification = @"MRQGovernmentAveragePriceDidChangeNotification";

NSString *const MRQGovernmentTaxLevelUserInfoKey = @"MRQGovernmentTaxLevelUserInfoKey";
NSString *const MRQGovernmentSalaryUserInfoKey = @"MRQGovernmentSalaryUserInfoKey";
NSString *const MRQGovernmentPensionUserInfoKey = @"MRQGovernmentPensionUserInfoKey";
NSString *const MRQGovernmentAveragePriceUserInfoKey = @"MRQGovernmentAveragePriceUserInfoKey";

@implementation MRQGovernment

- (instancetype)init
{
    self = [super init];
    if (self) {
        _taxLevel = 5.f;
        _salary = 1000.f;
        _pension = 500.f;
        _averagePrice = 10.f;
    }
    return self;
}

- (void) setTaxLevel:(CGFloat)taxLevel {
    
    _taxLevel = taxLevel;
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:taxLevel]
                                                           forKey:MRQGovernmentTaxLevelUserInfoKey];

    [[NSNotificationCenter defaultCenter] postNotificationName:MRQGovernmentTaxLevelDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
}

- (void) setSalary:(CGFloat)salary {
    
    _salary = salary;
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:salary]
                                                           forKey:MRQGovernmentSalaryUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MRQGovernmentSalaryDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
}

- (void) setPension:(CGFloat)pension {
   
    _pension = pension;
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:pension]
                                                           forKey:MRQGovernmentPensionUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MRQGovernmentPensionDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
}

- (void) setAveragePrice:(CGFloat)averagePrice {
    
    _averagePrice = averagePrice;
    
    NSDictionary* dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:averagePrice]
                                                           forKey:MRQGovernmentAveragePriceUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MRQGovernmentAveragePriceDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
}

@end
