//
//  OTGroup.m
//  iOSDev313201_TableViewEditingHW
//
//  Created by Oleg Tverdokhleb on 26.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTGroup.h"
#import "OTStudent.h"

@implementation OTGroup

+ (NSArray *)initWithDefaultGroups {
  NSMutableArray *groups = [NSMutableArray array];
  NSInteger groupCount = arc4random_uniform(11) + 5;
  
  for (int i = 0; i < groupCount; i += 1) {
    NSString *groupName = [NSString stringWithFormat:@"Group #%d", i];
    NSInteger studentInGroup = arc4random_uniform(4) + 2;
    OTGroup *group = [[OTGroup alloc] initGroupWithName:groupName studentsCount:studentInGroup];
    [groups addObject:group];
  }
  NSArray *result = [NSArray arrayWithArray:groups];
  return result;
}

- (OTGroup *)initGroupWithName:(NSString *)name studentsCount:(NSInteger)count {
  OTGroup *group = [[OTGroup alloc] init];
  group.name = name;
  group.count = count;
  
  NSMutableArray *students = [NSMutableArray array];
  for (int i = 0; i < count; i += 1) {
    [students addObject:[OTStudent initRandomStudent]];
  }
  group.students = students;
  
  return group;
}

@end
