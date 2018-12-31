//
//  OLTVMain.m
//  iOSDev4001_KVCHW
//
//  Created by Oleg Tverdokhleb on 20.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVMain.h"
#import "OLTVStudent.h"

@interface OLTVMain ()
@property (strong, nonatomic) OLTVStudent *student;
@end

@implementation OLTVMain

+ (OLTVMain *)sharedMain {
  static OLTVMain *main = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    main = [OLTVMain new];
  });
  return main;
}

- (void)dealloc {
  [self.student removeObserver:self forKeyPath:@"firstName"];
  [self.student removeObserver:self forKeyPath:@"lastName"];
  [self.student removeObserver:self forKeyPath:@"dateOfBirth"];
  [self.student removeObserver:self forKeyPath:@"gender"];
  [self.student removeObserver:self forKeyPath:@"averageGrade"];
}

- (void)main {
//  [self levelMaster];
  [self levelSuperman];
}

- (void)levelSuperman {
  NSMutableArray *tempArray = [NSMutableArray array];
  for (int i = 0; i < 50; i += 1) {
    OLTVStudent *student = [OLTVStudent new];
    [tempArray addObject:student];
  }
  NSArray *allStudents = [NSArray arrayWithArray:tempArray];
  NSLog(@"allStudents count = %@", [allStudents valueForKey:@"@count"]);
  
  NSArray *allNames = [allStudents valueForKeyPath:@"@unionOfObjects.firstName"];
  NSLog(@"allNames = %@", allNames);
  
  NSNumber *minDateOfBirth = [allStudents valueForKeyPath:@"@min.dateOfBirth"];
  NSNumber *maxDateOfBirth = [allStudents valueForKeyPath:@"@max.dateOfBirth"];
  NSLog(@"minDateOfBirth = %@", minDateOfBirth);
  NSLog(@"maxDateOfBirth = %@", maxDateOfBirth);
  
  NSNumber *sumAverageGrade = [allStudents valueForKeyPath:@"@sum.averageGrade"];
  NSNumber *avgAverageGrade = [allStudents valueForKeyPath:@"@avg.averageGrade"];
  NSLog(@"sumAverageGrade = %@", sumAverageGrade);
  NSLog(@"avgAverageGrade = %@", avgAverageGrade);
}

- (void)levelMaster {
  OLTVStudent *student1 = [OLTVStudent new];
  OLTVStudent *student2 = [OLTVStudent new];
  OLTVStudent *student3 = [OLTVStudent new];
  OLTVStudent *student4 = [OLTVStudent new];
  OLTVStudent *student5 = [OLTVStudent new];
  //NSArray *students = @[student1, student2, student3, student4, student5];
  
  [self addObserverForStudent:student1];
  self.student = student1;
  
  student1.friend = student2;
  student2.friend = student3;
  student3.friend = student4;
  student4.friend = student5;
  student5.friend = student1;
  
  [student2 setValue:@"CHANGED_FIRSTNAME" forKeyPath:@"firstName"];
  [student2 setValue:@"CHANGED_FIRSTNAME" forKeyPath:@"friend.firstName"];
  [student2 setValue:@"CHANGED_FIRSTNAME" forKeyPath:@"friend.friend.firstName"];
  [student2 setValue:@"CHANGED_FIRSTNAME" forKeyPath:@"friend.friend.friend.firstName"];
  [student2 setValue:@"CHANGED_FIRSTNAME" forKeyPath:@"friend.friend.friend.friend.firstName"];
  
  NSLog(@"student 1 firstname = %@", student1.firstName);
  NSLog(@"student 2 firstname = %@", student2.firstName);
  NSLog(@"student 3 firstname = %@", student3.firstName);
  NSLog(@"student 4 firstname = %@", student4.firstName);
  NSLog(@"student 5 firstname = %@", student5.firstName);
}

- (void)addObserverForStudent:(OLTVStudent *)student {
  [student addObserver:self forKeyPath:@"firstName" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
  [student addObserver:self forKeyPath:@"lastName" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
  [student addObserver:self forKeyPath:@"dateOfBirth" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
  [student addObserver:self forKeyPath:@"gender" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
  [student addObserver:self forKeyPath:@"averageGrade" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

#pragma mark - NSKeyValueObserving

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSString*, id> *)change context:(nullable void *)context {
  NSLog(@"observeValueForKeyPath %@", keyPath);
  NSLog(@"ofObject = %@", object);
  NSLog(@"change = %@", change);
  NSLog(@"----------------------------------------");
}

@end
