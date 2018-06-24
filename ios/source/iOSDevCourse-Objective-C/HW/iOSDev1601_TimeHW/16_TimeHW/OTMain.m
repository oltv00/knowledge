//
//  OTMain.m
//  16_TimeHW
//
//  Created by Oleg Tverdokhleb on 09.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTMain.h"
#import "OTStudent.h"

@interface OTMain ()

@property (strong, nonatomic) NSDate *currentDate;

@end

@implementation OTMain

+ (OTMain *)sharedMain {
    static OTMain *main = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        main = [[OTMain alloc] init];
    });
    return main;
}

- (void)main {
//    [self levelNoob];
//    [self levelStudent];
//    [self levelMaster];
    [self levelSuperman];
}

#pragma mark - Level Superman
- (void)levelSuperman {
//    [self item1];
//    [self item2];
    [self item3];
}

- (void)item3 {
    //Выведите количество рабочих дней для каждого месяца в текущем году (от начала до конца)
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy MMMM"];
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:today];
    NSInteger weekDay = 0;
    NSInteger workingDay = 0;
    
    for (int month = 1; month <= 12; month += 1) {
        comps.month = month;
        comps.day = 1;
        weekDay = 0;
        workingDay = 0;
        
        NSDate *enumDate = [calendar dateFromComponents:comps];
        NSString *stringDate = [dateFormatter stringFromDate:enumDate];
        
        while ([[calendar components:NSCalendarUnitMonth fromDate:enumDate] month] == month) {
            weekDay = [[calendar components:NSCalendarUnitWeekday fromDate:enumDate] weekday];
            
            if (weekDay != 1 && weekDay != 7) { // 1 and 7 not working days
                workingDay += 1;
            }
            comps.day += 1;
            enumDate = [calendar dateFromComponents:comps];
        }
        NSLog(@"Working days in %@ = %ld", stringDate, workingDay);
    }
}

- (void)item2 {
    //Выведите дату (число и месяц) для каждого воскресенья в текущем году (от начала до конца)
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:today];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy EEEE"];
    NSInteger thisYear = [components year];
    
    NSDateComponents *enumComp = [[NSDateComponents alloc] init];
    enumComp.year = thisYear;
    enumComp.month = 1;
    enumComp.weekday = 1;
    enumComp.weekdayOrdinal = 1;
    
    NSDate *enumDay = [calendar dateFromComponents:enumComp];
    
    while ([[calendar components:NSCalendarUnitYear fromDate:enumDay] year] == thisYear) {
    
        NSLog(@"Date: %@, Week Oridanl: %ld", [dateFormatter stringFromDate:enumDay], enumComp.weekdayOrdinal);
        
        enumComp.weekdayOrdinal += 1;
        enumDay = [calendar dateFromComponents:enumComp];
    }
}

- (void)item1 {
    //Выведите на экран день недели, для каждого первого дня каждого месяца в текущем году (от начала до конца)
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:today];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy EEEE"];
    components.day = 1;
    
    for (int i = 1; i <= 12; i += 1) {
        components.month = i;
        NSDate *firstDayOfMonth = [calendar dateFromComponents:components];
        NSInteger dayOfWeek = [[calendar components:NSCalendarUnitWeekday fromDate:firstDayOfMonth] weekday];
        NSInteger dayOfWeekOrdinal = [[calendar components:NSCalendarUnitWeekdayOrdinal fromDate:firstDayOfMonth] weekdayOrdinal];
        NSLog(@"Date: %@, Day of week: %ld, Ordinal: %ld", [dateFormatter stringFromDate:firstDayOfMonth], dayOfWeek, dayOfWeekOrdinal);
    }
}

#pragma mark - Level Master
- (void)levelMaster {
    NSMutableArray *arrayOfStudents = [NSMutableArray array];
    NSMutableDictionary *dictionaryOfStudents = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < 200; i += 1) {
        OTStudent *student = [[OTStudent alloc] init];
        [arrayOfStudents addObject:student];
    }
    
    [arrayOfStudents sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([[obj1 name] isEqualToString:[obj2 name]]) {
            if ([[obj1 lastName] isEqualToString:[obj2 lastName]]) {
                if ([[obj1 dateOfBirth] isEqualToDate:[obj2 dateOfBirth]]) {
                    return NSOrderedSame;
                } else {
                    return [[obj2 dateOfBirth] compare:[obj1 dateOfBirth]];
                }
            } else {
                return [[obj1 lastName] compare:[obj2 lastName]];
            }
        } else {
            return [[obj1 name] compare:[obj2 name]];
        }
        return NSOrderedAscending;
    }];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    for (OTStudent *student in arrayOfStudents) {
        NSLog(@"%@ %@ %@ Age: %ld", student.name, student.lastName, [dateFormatter stringFromDate:student.dateOfBirth],
              [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:student.dateOfBirth toDate:[NSDate date] options:0] year]);
        [dictionaryOfStudents setObject:student forKey:student.dateOfBirth];
    }
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(gratzStudent:) userInfo:dictionaryOfStudents repeats:YES];
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    
    [self ageDifferenceWithBirthDates:arrayOfStudents];
}

- (void)gratzStudent:(NSTimer *)timer {
    NSDictionary *dictionaryOfStudents = [timer userInfo];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    
    if (!self.currentDate) {
        self.currentDate = [dateFormatter dateFromString:@"01.01.1966"];
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    NSDateFormatter *birthFormatter = [[NSDateFormatter alloc] init];
    [birthFormatter setDateFormat:@"dd.MM"];
    
//    NSLog(@"Current date: %@", [dateFormatter stringFromDate:self.currentDate]);
    for (NSDate *dateOfBirth in [dictionaryOfStudents allKeys]) {
        NSString *stringKey = [birthFormatter stringFromDate:dateOfBirth];
        NSString *stringCurrentDate = [birthFormatter stringFromDate:self.currentDate];
//        NSLog(@"%@ %@", stringCurrentDate, stringKey);
        
        components = [calendar components: NSCalendarUnitYear
                                 fromDate:dateOfBirth
                                   toDate:self.currentDate options:0];
        
        if ([stringKey isEqualToString:stringCurrentDate] && [components year] >= 0) {
            NSString *name = [dictionaryOfStudents[dateOfBirth] name];
            NSString *lastName = [dictionaryOfStudents[dateOfBirth] lastName];
            NSString *stringDateOfBirth = [dateFormatter stringFromDate:dateOfBirth];

            NSLog(@"GRATZ %@ %@ %@, years old = %ld", name, lastName, stringDateOfBirth, [components year]);
        }
    }
    self.currentDate = [self.currentDate dateByAddingTimeInterval:86400];
}

- (void)ageDifferenceWithBirthDates:(NSArray *)responseArray {
    NSMutableArray *dates = [NSMutableArray array];
    for (id obj in responseArray) {
        [dates addObject:[obj dateOfBirth]];
    }
//    NSLog(@"%@", dates);
    [dates sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
//    NSLog(@"%@", dates);
    NSDate *earlyDate = [dates firstObject];
    NSDate *lateDate = [dates lastObject];
    NSLog(@"Early date = %@", earlyDate);
    NSLog(@"Late date = %@", lateDate);
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *componentYear = [[NSDateComponents alloc] init];
    NSDateComponents *componentMonth = [[NSDateComponents alloc] init];
    NSDateComponents *componentWeek = [[NSDateComponents alloc] init];
    NSDateComponents *componentDay = [[NSDateComponents alloc] init];
    
    componentYear = [calendar components: NSCalendarUnitYear fromDate:earlyDate toDate:lateDate options:0];
    componentMonth = [calendar components:NSCalendarUnitMonth fromDate:earlyDate toDate:lateDate options:0];
    componentWeek = [calendar components:NSCalendarUnitWeekOfYear fromDate:earlyDate toDate:lateDate options:0];
    componentDay = [calendar components: NSCalendarUnitDay fromDate:earlyDate toDate:lateDate options:0];

    NSLog(@"Difference ages %ld, months %ld, weeks %ld, days %ld", [componentYear year], [componentMonth month], [componentWeek weekOfYear], [componentDay day]);
}

#pragma mark - Level Student
- (void)levelStudent {
    NSMutableArray *arrayOfStudents = [NSMutableArray array];
    
    for (int i = 0; i < 200; i += 1) {
        OTStudent *student = [[OTStudent alloc] init];
        [arrayOfStudents addObject:student];
    }
    
    [arrayOfStudents sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([[obj1 name] isEqualToString:[obj2 name]]) {
            if ([[obj1 lastName] isEqualToString:[obj2 lastName]]) {
                if ([[obj1 dateOfBirth] isEqualToDate:[obj2 dateOfBirth]]) {
                    return NSOrderedSame;
                } else {
                    return [[obj2 dateOfBirth] compare:[obj1 dateOfBirth]];
                }
            } else {
                return [[obj1 lastName] compare:[obj2 lastName]];
            }
        } else {
            return [[obj1 name] compare:[obj2 name]];
        }
        return NSOrderedAscending;
    }];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    for (OTStudent *student in arrayOfStudents) {
        NSLog(@"%@ %@ %@", student.name, student.lastName, [dateFormatter stringFromDate:student.dateOfBirth]);
    }
}

#pragma mark - Level Noob
- (void)levelNoob {
    NSMutableArray *arrayOfStudents = [NSMutableArray array];
    
    for (int i = 0; i < 30; i += 1) {
        OTStudent *student = [[OTStudent alloc] init];
        [arrayOfStudents addObject:student];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    for (OTStudent *student in arrayOfStudents) {
        NSLog(@"%@ %@ %@", student.name, student.lastName, [dateFormatter stringFromDate:student.dateOfBirth]);
    }
}

@end
