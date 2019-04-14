//
//  OTMain.m
//  13_ThreadsHW
//
//  Created by Oleg Tverdokhleb on 07.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTMain.h"
#import "OTStudent.h"

@implementation OTMain

+ (OTMain *)sharedMain {
    static OTMain *main = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        main = [OTMain new];
    });
    return main;
}

- (void)dealloc {
    NSLog(@"%@ is deallocated", self);
}

- (void)main {
//    [self levelNoob];
//    [self levelStudent];
//    [self levelMaster];
//    [self levelSupermanWithInvocationMethod];
    [self levelSupermanWithBlockMethod];
}

- (void)levelSupermanWithBlockMethod {
    for (int i = 0; i < 10; i++) {
        OTStudent *student = [[OTStudent alloc] init];
        [student levelSupermanGuessAnswerWithBlock:523124 min:0 max:1000000 result:^(OTStudent *student, double endTime) {
//            NSLog(@"-------------------------------");
//            NSLog(@"Is main thread? - %@", [NSThread isMainThread] ? @"YES" : @"NO");
//            NSLog(@"%@ gave the correct answer", student.name);
            NSLog(@"%@ attempts %ld and spent time %f", student.name, student.attempts, endTime);
//            NSLog(@"-------------------------------");
        }];
    }
}

- (void)levelSupermanWithInvocationMethod {
    NSDictionary *params = @{@"correctAnswer" : @(15262),
                             @"min" : @(0),
                             @"max" : @(100000)};
    
    for (int i = 0; i < 10; i++) {
        OTStudent *student = [[OTStudent alloc] init];
        [student levelSupermanGuessAnswerWithInvocationMethod:params result:^(OTStudent *student, double endTime) {
            NSLog(@"-------------------------------");
            NSLog(@"Is main thread? - %@", [NSThread isMainThread] ? @"YES" : @"NO");
            NSLog(@"%@ gave the correct answer", student.name);
            NSLog(@"%@ attempts %ld and spent time %f", student.name, student.attempts, endTime);
            NSLog(@"-------------------------------");
        }];
    }
}

- (void)levelMaster {
    for (int i = 0; i < 10; i++) {
        OTStudent *student = [[OTStudent alloc] init];
        [student levelMasterGuessAnswer:67895 min:0 max:100000 result:^(OTStudent *student, double endTime) {
            NSLog(@"-------------------------------");
            NSLog(@"%@ gave the correct answer", student.name);
            NSLog(@"%@ attempts %ld and spent time %f", student.name, student.attempts, endTime);
            NSLog(@"-------------------------------");
        }];
    }
}

- (void)levelStudent {
    for (int i = 0; i < 10; i++) {
        OTStudent *student = [[OTStudent alloc] init];
        [student levelStudentGuessAnswer:5000 min:0 max:10000 result:^(OTStudent *student, double endTime) {
            NSLog(@"-------------------------------");
            NSLog(@"%@ gave the correct answer", student.name);
            NSLog(@"%@ attempts %ld and spent time %f", student.name, student.attempts, endTime);
            NSLog(@"-------------------------------");
        }];
    }
}

- (void)levelNoob {
    for (int i = 0; i < 5; i++) {
        OTStudent *student = [[OTStudent alloc] init];
        [student levelNoobGuessAnswer:5000 min:0 max:10000];
    }
}

@end
