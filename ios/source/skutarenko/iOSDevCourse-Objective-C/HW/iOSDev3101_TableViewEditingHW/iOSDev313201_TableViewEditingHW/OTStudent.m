//
//  OTStudent.m
//  iOSDev313201_TableViewEditingHW
//
//  Created by Oleg Tverdokhleb on 26.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTStudent.h"
#import "Data.h"

@implementation OTStudent

+ (OTStudent *)initRandomStudent {
  OTStudent *student = [[OTStudent alloc] init];
  
  student.name = firstNames[arc4random_uniform(50)];
  student.lastname = lastNames[arc4random_uniform(50)];
  student.averageScore = 2 + (double)arc4random_uniform(30000) / 10000;
  
  return student;
}

@end