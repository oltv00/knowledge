//
//  OTMain.m
//  15_BitsHW
//
//  Created by Oleg Tverdokhleb on 09.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTMain.h"
#import "OTStudent.h"

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
//    [self levelNoob];
//    [self levelStudent];
//    [self levelMaster];
//    [self levelSuperman];
    [self levelSuperman2];
}

#pragma mark - Level Superman
- (void)levelSuperman2 {
    NSInteger value = arc4random_uniform(INT32_MAX);
    NSMutableString *result = [[NSMutableString alloc] init];
    NSLog(@"Random value %ld in range from 0 to %d", value, INT32_MAX);
    for (NSInteger index = [self quantityBits:value]; index >= 0; index -= 1) {
        NSInteger maskBit = 1 << index;
        if ((value % maskBit) == 0) {
            [result appendString:@"0"];
        } else {
            [result appendString:@"1"];
        }
        if (index % 8 == 0) {
            [result appendString:@" "];
        }
    }
    NSLog(@"%@", result);
}

- (NSInteger)quantityBits:(NSInteger)value {
    NSInteger bits = 0;
    NSInteger balance;
    NSInteger current = value;
    
    while (current != 0) {
        balance = current % 2;
        current = current / 2;
        bits += 1;
    }
    return --bits;
}

- (void)levelSuperman {
    NSInteger integerValue = arc4random();
    NSInteger tempValue = 0;
    NSInteger space = 0;
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSMutableArray *array = [NSMutableArray array];
//    NSLog(@"Start Value = %ld", integerValue);
    
    for (int i = 31; i >= 0; i -= 1) {
        tempValue = pow(2, i);
//        NSLog(@"Check Value = %ld", tempValue);
        if (space == 8) {
            [resultString appendString:@"_"];
            space = 0;
        } else if ((integerValue - tempValue) < 0) {
            [resultString appendString:@"0"];
        } else {
            integerValue -= tempValue;
//            NSLog(@"Start Value changed = %ld", integerValue);
            [resultString appendString:@"1"];
        }
        space += 1;
//        NSLog(@"%@", resultString);
//        NSLog(@"-----CYCLE------");
        [array addObject:[resultString copy]];
    }
//    NSLog(@"%@", resultString);
    for (int i = 0; i < [array count]; i += 1) {
        NSString *bit = array[i];
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(bitPrint:) userInfo:bit repeats:NO];
        [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:i]];
    }
}

- (void)bitPrint:(NSTimer *)bitTimer {
    NSLog(@"%@", [bitTimer userInfo]);
}

#pragma mark - Level Master
- (void)levelMaster {
    NSMutableArray *arrayOfStudents = [NSMutableArray array];
    for (int i = 0; i < 10; i += 1) {
        OTStudent *student = [[OTStudent alloc] init];
        student.subjectType = arc4random_uniform(256);
        [arrayOfStudents addObject:student];
        //        NSLog(@"%@", [student descriptionStudent]);
    }
    
    NSMutableArray *arrayOfStudentsEngineers = [NSMutableArray array];
    NSMutableArray *arrayOfStudentsHumanitarians = [NSMutableArray array];
    NSInteger countOfDevelopers = 0;
    for (OTStudent *student in arrayOfStudents) {
        if (student.subjectType & OTStudentSubjectTypeDevelopment) {
            countOfDevelopers += 1;
        }
        if (student.subjectType & OTStudentSubjectTypeEngineering) {
            [arrayOfStudentsEngineers addObject:student];
        } else {
            [arrayOfStudentsHumanitarians addObject:student];
        }
    }
    NSLog(@"Count of Developers = %ld", countOfDevelopers);
    NSLog(@"ENGINEERS");
    for (OTStudent *student in arrayOfStudentsEngineers) {
        [self biologyCancel:student];
        NSLog(@"%@",[student descriptionStudent]);
    }
    NSLog(@"HUMANITARIANS");
    for (OTStudent *student in arrayOfStudentsHumanitarians) {
        [self biologyCancel:student];
        NSLog(@"%@",[student descriptionStudent]);
    }
}

- (void)biologyCancel:(OTStudent *)student {
    if (student.subjectType & OTStudentSubjectTypeBiology) {
        student.subjectType = student.subjectType ^ OTStudentSubjectTypeBiology;
        NSLog(@"Biology is cancelled");
    }
}

#pragma mark - Level Student
- (void)levelStudent {
    NSMutableArray *arrayOfStudents = [NSMutableArray array];
    for (int i = 0; i < 10; i += 1) {
        OTStudent *student = [[OTStudent alloc] init];
        student.subjectType = arc4random_uniform(256);
        [arrayOfStudents addObject:student];
        //        NSLog(@"%@", [student descriptionStudent]);
    }
    
    NSMutableArray *arrayOfStudentsEngineers = [NSMutableArray array];
    NSMutableArray *arrayOfStudentsHumanitarians = [NSMutableArray array];
    NSInteger countOfDevelopers = 0;
    for (OTStudent *student in arrayOfStudents) {
        if (student.subjectType & OTStudentSubjectTypeDevelopment) {
            countOfDevelopers += 1;
        }
        if (student.subjectType & OTStudentSubjectTypeEngineering) {
            [arrayOfStudentsEngineers addObject:student];
        } else {
            [arrayOfStudentsHumanitarians addObject:student];
        }
    }
    NSLog(@"Count of Developers = %ld", countOfDevelopers);
    NSLog(@"ENGINEERS");
    for (OTStudent *student in arrayOfStudentsEngineers) {
        NSLog(@"%@",[student descriptionStudent]);
    }
    NSLog(@"HUMANITARIANS");
    for (OTStudent *student in arrayOfStudentsHumanitarians) {
        NSLog(@"%@",[student descriptionStudent]);
    }

}

#pragma mark - Level Noob
- (void)levelNoob {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 10; i += 1) {
        OTStudent *student = [[OTStudent alloc] init];
        student.subjectType = arc4random_uniform(256);
        [array addObject:student];
//        NSLog(@"%@", [student descriptionStudent]);
    }
}

@end
