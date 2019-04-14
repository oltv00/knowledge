//
//  OTMain.m
//  16_TimeTest
//
//  Created by Oleg Tverdokhleb on 09.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTMain.h"
#import "OTObject.h"

@implementation OTMain

+ (OTMain *)sharedMain {
    static OTMain *main = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        main = [OTMain new];
    });
    return main;
}

- (void)main {
//    [self level1];
//    [self level2];
//    [self level3];
//    [self level4];
//    [self level5];
//    [self level6];
//    [self level7];
//    [self level8];
//    [self level9];
    [self level10];
}

- (void)level10 {
    OTObject *obj = [[OTObject alloc] init];
    
}

- (void)level9 {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(timerTest:)
                                   userInfo:nil // [timer userInfo] - dictionary
                                    repeats:YES];
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:5]];
}

- (void)timerTest:(NSTimer *)timer {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss:SSS"];
    NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
    
    [timer invalidate];
}

- (void)level8 {
    NSDate *date1 = [NSDate date];
    NSDate *date2 = [NSDate dateWithTimeIntervalSinceNow:-1000000];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute
                                               fromDate:date2
                                                 toDate:date1
                                                options:0];
    NSLog(@"%@", components);
}

- (void)level7 {
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    NSLog(@"%@", components);
}

- (void)level6 {
    NSDateFormatter* dFormatter = [[NSDateFormatter alloc] init];
    [dFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    
    NSDate *date2 = [dFormatter dateFromString:@"2008/05/17 22:53"];
    NSLog(@"%@", date2);
}

- (void)level5 {
    NSDate *date = [NSDate date];
    NSDateFormatter* dFormatter = [[NSDateFormatter alloc] init];
    
    [dFormatter setDateFormat:@"yyyy M MM MMM MMMM MMMMM"];
    NSLog(@"%@", [dFormatter stringFromDate:date]);
    
    [dFormatter setDateFormat:@"yyyy/MM/dd EEE EEEE EEEEE"];
    NSLog(@"%@", [dFormatter stringFromDate:date]);
    
    [dFormatter setDateFormat:@"yyyy/MM/dd EEE HH:mm:SSS a W w"];
    NSLog(@"%@", [dFormatter stringFromDate:date]);

}

- (void)level4 {
    //Date ENUM kFormates
    NSDate *date = [NSDate date];
    NSDateFormatter* dFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatterStyle style = 0;
    while (style < 5) {
        style += 1;
        [dFormatter setDateStyle:style];
        NSLog(@"%@", [dFormatter stringFromDate:date]);
    }
//    NSDateFormatterNoStyle = kCFDateFormatterNoStyle,
//    NSDateFormatterShortStyle = kCFDateFormatterShortStyle,
//    NSDateFormatterMediumStyle = kCFDateFormatterMediumStyle,
//    NSDateFormatterLongStyle = kCFDateFormatterLongStyle,
//    NSDateFormatterFullStyle = kCFDateFormatterFullStyle
}

- (void)level3 {
    NSDate *dateSinceNow = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDate *dateSince1970 = [NSDate dateWithTimeIntervalSince1970:0];
    NSDate *dateTimeInterval = [NSDate dateWithTimeInterval:10000 sinceDate:[NSDate date]];
    NSDate *dateSinceReferenceDate = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
    
    NSLog(@"dateSinceNow %@", dateSinceNow);
    NSLog(@"dateSince1970 %@", dateSince1970);
    NSLog(@"dateTimeInterval %@", dateTimeInterval);
    NSLog(@"dateSinceReferenceDate %@", dateSinceReferenceDate);
}

- (void)level2 {
    //Сравниевание даты
    NSDate *date = [NSDate date];
    
//    - (NSDate *)earlierDate:(NSDate *)anotherDate;
//    - (NSDate *)laterDate:(NSDate *)anotherDate;
//    - (NSComparisonResult)compare:(NSDate *)other;
//    - (BOOL)isEqualToDate:(NSDate *)otherDate;
    
    if ([date compare:[date dateByAddingTimeInterval:-5000]]) {
        NSLog(@"%ld", [date compare:[date dateByAddingTimeInterval:-5000]]);
    }
    
    if ([date compare:[date dateByAddingTimeInterval:-5000]]) {
        NSLog(@"%ld", [date compare:[date dateByAddingTimeInterval:5000]]);
    }
    
    if ([date compare:date]) {
        NSLog(@"%ld", [date compare:[date dateByAddingTimeInterval:-5000]]);
    }
}

- (void)level1 {
    //Date creating
    NSDate *date = nil;
    date = [NSDate date];
    
    NSLog(@"%@", date);
    NSLog(@"%@", [date dateByAddingTimeInterval:5000]);
    NSLog(@"%@", [date dateByAddingTimeInterval:-5000]);
}

@end
