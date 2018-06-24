//
//  OLTVMain.m
//  iOSDev4001_KVCTest
//
//  Created by Oleg Tverdokhleb on 16/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVMain.h"
#import "OLTVGroup.h"
#import "OLTVStudent.h"

@interface OLTVMain ()
@property (strong, nonatomic) NSArray *groups;
@property (strong, nonatomic) OLTVGroup *group;
@property (strong, nonatomic) OLTVStudent *student;
@end

@implementation OLTVMain

+ (OLTVMain *)sharedMain {
  static OLTVMain *main = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    main = [[OLTVMain alloc] init];
  });
  return main;
}

- (void)main {
//  [self level1];
//  [self level2];
//  [self level3];
//  [self level4];
//  [self level5];
  [self level6];
}

- (void)dealloc {
  [self.student removeObserver:self forKeyPath:@"name"];
  [self.group removeObserver:self forKeyPath:@"students"];
}

#pragma mark - Levels

- (void)level6 {
  NSMutableArray *tempArray = [NSMutableArray array];
  
  OLTVGroup *group1 = [OLTVGroup new];
  OLTVGroup *group2 = [OLTVGroup new];
  
  //group1
  for (int i = 0; i < 10; i += 1) {
    OLTVStudent *student = [OLTVStudent new];
    [tempArray addObject:student];
  }
  group1.students = [NSArray arrayWithArray:tempArray];
  tempArray = [NSMutableArray array];
  for (int i = 0; i < 10; i += 1) {
    OLTVStudent *student = [OLTVStudent new];
    [tempArray addObject:student];
  }
  group2.students = [NSArray arrayWithArray:tempArray];
  
  self.groups = @[group1, group2];
  NSLog(@"groups count = %@", [self valueForKeyPath:@"groups.@count"]);
  
  NSArray *allStudents = [self valueForKeyPath:@"groups.@distinctUnionOfArrays.students"];
  NSLog(@"%@", allStudents);
  
  NSNumber *minAge = [allStudents valueForKeyPath:@"@min.age"];
  NSNumber *maxAge = [allStudents valueForKeyPath:@"@max.age"];
  NSNumber *sumAge = [allStudents valueForKeyPath:@"@sum.age"];
  NSNumber *avgAge = [allStudents valueForKeyPath:@"@avg.age"];
  
  NSLog(@"minAge = %@", minAge);
  NSLog(@"maxAge = %@", maxAge);
  NSLog(@"sumAge = %@", sumAge);
  NSLog(@"avgAge = %@", avgAge);
  
  NSArray *allNames = [allStudents valueForKeyPath:@"@unionOfObjects.name"];
  NSLog(@"allNames = %@", allNames);
}

- (void)level5 {
  OLTVStudent *student1 = [OLTVStudent new];
  NSString *name1 = @"Alex98";
  NSString *name2 = (NSString *)@123;
  NSString *name3 = @"ALEX";
  
  NSError *error = nil;
  if (![student1 validateValue:&name1 forKey:@"name" error:&error]){
    NSLog(@"%@", error);
  } else {student1.name = name1;}
  
  if (![student1 validateValue:&name2 forKey:@"name" error:&error]){
    NSLog(@"%@", error);
    } else {student1.name = name2;}

  if (![student1 validateValue:&name3 forKey:@"name" error:&error]){
    NSLog(@"%@", error);
  } else {student1.name = name3;}
  
}

- (void)level4 {
  OLTVGroup *group1 = [OLTVGroup new];
  
  OLTVStudent *student1 = [OLTVStudent new];
  OLTVStudent *student2 = [OLTVStudent new];
  OLTVStudent *student3 = [OLTVStudent new];
  OLTVStudent *student4 = [OLTVStudent new];
  
  group1.students = @[student1, student2, student3, student4];

  self.student = student1;
  NSLog(@"valueForKeyPath \"student.name\" = %@", [self valueForKeyPath:@"student.name"]);
}

- (void)level3 {
  OLTVGroup *group1 = [OLTVGroup new];
  self.group = group1;
  [group1 addObserver:self forKeyPath:@"students" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
  
  OLTVStudent *student1 = [OLTVStudent new];
  OLTVStudent *student2 = [OLTVStudent new];
  OLTVStudent *student3 = [OLTVStudent new];
  OLTVStudent *student4 = [OLTVStudent new];
  
  group1.students = @[student1, student2, student3, student4];
  NSLog(@"group1.students = %@", group1.students);
  
  NSMutableArray *mArray = [group1 mutableArrayValueForKey:@"students"];
  [mArray removeLastObject];
  NSLog(@"mArray = %@", mArray);
  NSLog(@"mArray class = %@", [mArray class]);
  NSLog(@"group1.students = %@", group1.students);
  NSLog(@"group1.students class = %@", [group1.students class]);
}

- (void)level2 {
  OLTVStudent *student = [OLTVStudent new];
  
  [student addObserver:self forKeyPath:@"name" options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
               context:nil];
  student.name = @"Alex";
  student.age = 20;
  NSLog(@"%@", student);
  
  [student setValue:@"Roger" forKey:@"name"];
  NSLog(@"%@", student);
  
  NSLog(@"value = %@ forkey = %@", [student valueForKey:@"name"], @"name");
 
  [student changeName];
  NSLog(@"%@", student);
  
  self.student = student;
}

- (void)level1 {
  OLTVStudent *student = [OLTVStudent new];
  student.name = @"Alex";
  student.age = 20;
  NSLog(@"%@", student);
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
  
  NSDictionary *dict = @{@"observeValueForKeyPath" : keyPath,
                         @"ofObject" : object,
                         @"change" : change};
  
  NSLog(@"%@", dict);
}

@end
