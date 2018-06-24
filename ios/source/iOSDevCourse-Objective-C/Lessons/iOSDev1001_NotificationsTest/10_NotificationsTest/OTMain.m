//
//  OTMain.m
//  10_NotificationsTest
//
//  Created by Oleg Tverdokhleb on 02.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTMain.h"
#import "OTGovernment.h"
#import "OTDoctor.h"

@interface OTMain ()

@property (strong, nonatomic) OTGovernment *government;

@end

@implementation OTMain

- (void)main {
    [self addNotifications];
    [self setup];
}

- (void)setup {
    self.government = [[OTGovernment alloc] init];
    OTDoctor *doctor = [[OTDoctor alloc] init];
    
    self.government.salary = 750;
    self.government.salary = 500;
    self.government.salary = 750;
    self.government.salary = 1000;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification

- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(governmentNotification:)
                                                 name:OTGovernmentTaxLevelDidChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(governmentNotification:)
                                                 name:OTGovernmentSalaryDidChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(governmentNotification:)
                                                 name:OTGovernmentPensionDidChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(governmentNotification:)
                                                 name:OTGovernmentAveragePriceDidChangeNotification
                                               object:nil];
}

- (void)governmentNotification:(NSNotification *)notification {
//    NSLog(@"governmentNotification userInfo = %@", notification.userInfo);
}

@end
