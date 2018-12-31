//
//  Student.m
//  iOSDev373801_MapKit
//
//  Created by Oleg Tverdokhleb on 08/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "Student.h"
#import "Data.h"


@implementation Student

+ (NSArray *)initStudentsWithCount:(NSInteger)count inCenter:(MKMapPoint)center maxDelta:(double)maxDelta {
  NSMutableArray *students = [NSMutableArray array];
  for (int i = 0; i < count; i += 1) {
    Student *student = [[Student alloc] initWithCenter:center maxDelta:maxDelta];
    [students addObject:student];
  }
  return students;
}

- (instancetype)initWithCenter:(MKMapPoint)center maxDelta:(double)maxDelta {
  self = [super init];
  if (self) {
    _firstName = firstNames[arc4random_uniform(50)];
    _lastName = lastNames[arc4random_uniform(50)];
    _birthday = [self randomBirthday];
    _gender = arc4random_uniform(100000) % 2;
    
    double deltaX = arc4random_uniform(maxDelta);
    double deltaY = arc4random_uniform(maxDelta);
    _x = arc4random() % 2 ? center.x + deltaX : center.x - deltaX;
    _y = arc4random() % 2 ? center.y + deltaY : center.y - deltaY;
  }
  return self;
}

- (NSDate *)randomBirthday {
  NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
  
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
  
  comps.year += arc4random_uniform(50);
  comps.month += arc4random_uniform(50);
  comps.day += arc4random_uniform(50);
  
  date = [calendar dateFromComponents:comps];
  return date;
}

- (NSString *)stringFromDate:(NSDate *)date {
  NSDateFormatter *df = [NSDateFormatter new];
  [df setDateFormat:@"dd.MM.yyyy"];
  return [df stringFromDate:date];
}

@end
