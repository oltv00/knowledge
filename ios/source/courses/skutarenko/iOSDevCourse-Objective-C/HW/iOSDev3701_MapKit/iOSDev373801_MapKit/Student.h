//
//  Student.h
//  iOSDev373801_MapKit
//
//  Created by Oleg Tverdokhleb on 08/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKGeometry.h>

typedef NS_ENUM(NSInteger, Gender) {
  StudentGenderMale,
  StudentGenderFemale
};

@interface Student : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSDate *birthday;
@property (assign, nonatomic) Gender gender;
@property (assign, nonatomic) double x;
@property (assign, nonatomic) double y;

+ (NSArray *)initStudentsWithCount:(NSInteger)count inCenter:(MKMapPoint)center maxDelta:(double)maxDelta;
- (NSString *)stringFromDate:(NSDate *)date;

@end
