//
//  OTStudent.m
//  15_BitsHW
//
//  Created by Oleg Tverdokhleb on 09.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTStudent.h"
#import "Data.h"

@implementation OTStudent

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = firstNames[arc4random_uniform(50)];
        self.lastName = lastNames[arc4random_uniform(50)];
//        self.subjectType
    }
    return self;
}

- (NSString *)descriptionStudent {
    NSString *returnString = [NSString stringWithFormat:@"\nName = %@\nLastname = %@\n"
                                                        "Biology = %@\n"
                                                        "Math = %@\n"
                                                        "Development = %@\n"
                                                        "Engineering = %@\n"
                                                        "Art = %@\n"
                                                        "Phycology = %@\n"
                                                        "Anatomy = %@\n"
                                                        "---------------------------------",
                                                        self.name, self.lastName,
                                                        [self answerType:OTStudentSubjectTypeBiology],
                                                        [self answerType:OTStudentSubjectTypeMath],
                                                        [self answerType:OTStudentSubjectTypeDevelopment],
                                                        [self answerType:OTStudentSubjectTypeEngineering],
                                                        [self answerType:OTStudentSubjectTypeArt],
                                                        [self answerType:OTStudentSubjectTypePhycology],
                                                        [self answerType:OTStudentSubjectTypeAnatomy]];
    return returnString;
}

- (NSString *)answerType:(OTStudentSubjectType) type {
    return self.subjectType & type ? @"yes" : @"no";
}

@end
