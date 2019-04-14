//
//  OTMain.m
//  15_BitsTest
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
        main = [[OTMain alloc] init];
    });
    return main;
}

- (void)main {
//    [self level1];
    [self level2];
}

- (void)level2 {
    OTStudent *student = [OTStudent new];
    student.subjectType =   OTStudentSubjectTypeAnatomy | OTStudentSubjectTypeDevelopment |
                            OTStudentSubjectTypeEngineering | OTStudentSubjectTypeMath;
    NSLog(@"%@", [student descriptionLevel2]);
}

- (void)level1 {
    OTStudent *student = [[OTStudent alloc] init];
    
    student.studiesAnatomy = YES;
    student.studiesDevelopment = YES;
    student.studiesEngineering = YES;
    student.studiesMath = YES;
    student.studiesPhycology = NO;
    student.studiesArt = NO;
    student.studiesBiology = NO;
    
    NSLog(@"%@", [student descriptionLevel1]);
}

@end
