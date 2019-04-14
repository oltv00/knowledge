//
//  Student.m
//  iOSDev3501_TableViewSearchHW
//
//  Created by Oleg Tverdokhleb on 01.05.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "Student.h"
#import "Data.h"

@implementation Student

+ (NSArray *)initializeStudentsCount:(NSInteger)count {
  NSMutableArray *students = [NSMutableArray array];
  
  for (int i = 0; i < count; i += 1) {
    Student *student = [[Student alloc] init];
    [students addObject:student];
  }
  return students;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.name = firstNames[arc4random_uniform(50)];
    self.lastname = lastNames[arc4random_uniform(50)];
    self.birthday = [self birthdayByRandomDate];
    
    self.nameRange = NSMakeRange(0, 0);
    self.lastnameRange = NSMakeRange(0, 0);
    
  }
  return self;
}

- (NSDate *)birthdayByRandomDate {
  
  NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:0];
  
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
  comps.year += arc4random_uniform(50);
  comps.month += arc4random_uniform(50);
  comps.day += arc4random_uniform(50);
  
  date = [calendar dateFromComponents:comps];
  date = [date dateByAddingTimeInterval:14400];
  
  return date;
}

- (NSString *)stringFromDate:(NSDate *)date {
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"dd.MM.yyyy"];
  return [df stringFromDate:date];
}

- (NSInteger)getMonth:(NSDate *)date {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:date];
  return month;
}

@end
