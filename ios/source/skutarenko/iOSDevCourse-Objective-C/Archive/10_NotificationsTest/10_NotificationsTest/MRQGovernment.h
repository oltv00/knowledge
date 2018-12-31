//
//  MRQGovernment.h
//  10_NotificationsTest
//
//  Created by Oleg Tverdokhleb on 21.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const MRQGovernmentTaxLevelDidChangeNotification;
extern NSString *const MRQGovernmentSalaryDidChangeNotification;
extern NSString *const MRQGovernmentPensionDidChangeNotification;
extern NSString *const MRQGovernmentAveragePriceDidChangeNotification;

extern NSString *const MRQGovernmentTaxLevelUserInfoKey;
extern NSString *const MRQGovernmentSalaryUserInfoKey;
extern NSString *const MRQGovernmentPensionUserInfoKey;
extern NSString *const MRQGovernmentAveragePriceUserInfoKey;

@interface MRQGovernment : NSObject

@property (assign, nonatomic) CGFloat taxLevel;
@property (assign, nonatomic) CGFloat salary;
@property (assign, nonatomic) CGFloat pension;
@property (assign, nonatomic) CGFloat averagePrice;

@end
