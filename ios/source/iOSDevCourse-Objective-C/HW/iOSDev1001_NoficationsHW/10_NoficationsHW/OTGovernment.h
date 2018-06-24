//
//  OTGovernment.h
//  10_NoficationsHW
//
//  Created by Oleg Tverdokhleb on 03.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const OTGovernmentTaxLevelDidChangeNotification;
extern NSString *const OTGovernmentSalaryDidChangeNotification;
extern NSString *const OTGovernmentPensionDidChangeNotification;
extern NSString *const OTGovernmentAveragePriceDidChangeNotification;

extern NSString *const OTGovernmentTaxLevelUserInfoKey;
extern NSString *const OTGovernmentSalaryUserInfoKey;
extern NSString *const OTGovernmentPensionUserInfoKey;
extern NSString *const OTGovernmentAveragePriceUserInfoKey;

@interface OTGovernment : NSObject

@property (assign, nonatomic) CGFloat taxLevel;
@property (assign, nonatomic) CGFloat salary;
@property (assign, nonatomic) CGFloat pension;
@property (assign, nonatomic) CGFloat averagePrice;

@end
