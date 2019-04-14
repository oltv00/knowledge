//
//  OTStudent.m
//  iOSDev3001_TableViewDynamicCellsHW
//
//  Created by Oleg Tverdokhleb on 24.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTStudent.h"
#import "Data.h"

@implementation OTStudent

+ (NSArray *)initStudentsWithCount:(NSInteger)count {
  NSMutableArray *groups = [NSMutableArray array];
  NSMutableArray *bestStudents = [NSMutableArray array];
  NSMutableArray *goodStudents = [NSMutableArray array];
  NSMutableArray *normalStudents = [NSMutableArray array];
  NSMutableArray *badStudents = [NSMutableArray array];
  
  for (int i = 0; i < count; i += 1) {
    OTStudent *student = [[OTStudent alloc] init];
    student.name = firstNames[arc4random_uniform(50)];
    student.lastname = lastNames[arc4random_uniform(50)];
    student.averageScore = 2 + (double)arc4random_uniform(30000) / 10000;
    
    if (student.averageScore > 4.8f) {
      [bestStudents addObject:student];
    } else if (student.averageScore > 4 && student.averageScore < 4.8f) {
      [goodStudents addObject:student];
    } else if (student.averageScore > 3 && student.averageScore < 4) {
      [normalStudents addObject:student];
    } else {
      [badStudents addObject:student];
    }
  }
  
  NSSortDescriptor *nameDesc = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
  NSSortDescriptor *lastnameDesc = [NSSortDescriptor sortDescriptorWithKey:@"lastname" ascending:YES];
  NSSortDescriptor *averageScoreDesc = [NSSortDescriptor sortDescriptorWithKey:@"averageScore" ascending:YES];
  
  [bestStudents sortUsingDescriptors:@[nameDesc, lastnameDesc, averageScoreDesc]];
  [goodStudents sortUsingDescriptors:@[nameDesc, lastnameDesc, averageScoreDesc]];
  [normalStudents sortUsingDescriptors:@[nameDesc, lastnameDesc, averageScoreDesc]];
  [badStudents sortUsingDescriptors:@[nameDesc, lastnameDesc, averageScoreDesc]];
  
  [groups addObject:bestStudents];
  [groups addObject:goodStudents];
  [groups addObject:normalStudents];
  [groups addObject:badStudents];

  NSArray *resultArray = [NSArray arrayWithArray:groups];
  return resultArray;
}

@end
