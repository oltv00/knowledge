//
//  OTStudent.m
//  16_TimeHW
//
//  Created by Oleg Tverdokhleb on 09.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTStudent.h"
#import "Data.h"

@implementation OTStudent

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = firstNames[arc4random_uniform(51)];
        self.lastName = lastNames[arc4random_uniform(50)];
//        self.name = @"name";
//        self.lastName = @"lastname";
        self.dateOfBirth = [self date];
        if (!self.name || !self.lastName || !self.dateOfBirth) {
            
        }
    }
    return self;
}

- (NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //random date
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate dateWithTimeIntervalSince1970:0]];
    components.year = 1966 + arc4random_uniform(35);
    components.month = 1 + arc4random_uniform(12);
    components.day = 1 + arc4random_uniform(30);
    
    //settings date format
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *stringDate = [NSString stringWithFormat:@"%ld.%ld.%ld", [components year], [components month], [components day]];
    NSDate *date = [dateFormatter dateFromString:stringDate];
    
    if (!date) {
        date = [self date];
    }
    
    return date;
}

@end
