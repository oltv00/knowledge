//
//  OTMain.m
//  12_BlocksHW
//
//  Created by Oleg Tverdokhleb on 06.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTMain.h"
#import "OTStudent.h"
#import "OTPatient.h"
#import "OTDoctor.h"

typedef void(^LevelNoobBlock)(void);

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
    [self levelSuperman];
}

#pragma mark - Level Superman

- (void)levelSuperman {
    OTDoctor *doctor = [[OTDoctor alloc] initWithName:@"JOHN"];
    __weak OTDoctor *weakDoctor = doctor;
    for (int patientsCount = 0; patientsCount < 100; patientsCount++) {
        OTPatient *patient = [[OTPatient alloc] initWithPatientID:[NSString stringWithFormat:@"%d", patientsCount]];
        [patient feelsBad:^(OTPatient *patient) {
            NSTimeInterval interval = 5 + arc4random_uniform(10);
            [weakDoctor performSelector:@selector(patientFeelsBad:)
                             withObject:patient
                             afterDelay:interval];
        }];
    }
}

#pragma mark - Level Master

- (void)levelMaster {
    OTDoctor *doctor = [[OTDoctor alloc] initWithName:@"JOHN"];
    __weak OTDoctor *weakDoctor = doctor;
    for (int patientsCount = 0; patientsCount < 100; patientsCount++) {
        OTPatient *patient = [[OTPatient alloc] initWithPatientID:[NSString stringWithFormat:@"%d", patientsCount]];
        [patient feelsBad:^(OTPatient *patient) {
            [weakDoctor patientFeelsBad:patient];
        }];
    }
}

#pragma mark - Level Student

- (void)levelStudent {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        OTStudent *student = [OTStudent new];
        [array addObject:student];
    }
//    [self printArray:array];
    [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([[obj1 lastName] isEqualToString:[obj2 lastName]]) {
            return [[obj1 name] compare:[obj2 name]];
        } else {
            return [[obj1 lastName] compare:[obj2 lastName]];
        }
    }];
    [self printArray:array];
}

- (void)printArray:(NSArray *) array {
    for (id obj in array) {
        NSLog(@"%@ %@", [obj name], [obj lastName]);
    }
    NSLog(@"-----");
}

#pragma mark - Level Noob

- (void)levelNoob {
    void(^blockOne)(void) = ^() {
        NSLog(@"blockOne");
    };
    blockOne();
    
    void(^blockTwo)(NSString *) = ^(NSString *string) {
        NSLog(@"%@", string);
    };
    blockTwo(@"blockTwo");
    
    NSString *(^blockThree)(NSString *) = ^(NSString *string) {
        return [NSString stringWithFormat:@"%@", string];
    };
    NSLog(@"%@", blockThree(@"blockThree"));
    
    [self methodWithBlock:^{
        NSLog(@"Hello from noob level");
    }];
}

- (void)methodWithBlock:(LevelNoobBlock) block {
    block();
}

@end
