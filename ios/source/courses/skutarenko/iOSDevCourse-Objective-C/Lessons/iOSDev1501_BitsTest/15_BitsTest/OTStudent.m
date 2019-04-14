//
//  OTStudent.m
//  15_BitsTest
//
//  Created by Oleg Tverdokhleb on 09.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTStudent.h"

@implementation OTStudent

- (NSString *)descriptionLevel2 {
    return [NSString stringWithFormat:  @"\nStudent studies:\n"
            "biology = %@\n"
            "math = %@\n"
            "development = %@\n"
            "engineering = %@\n"
            "art = %@\n"
            "phycology = %@\n"
            "anatomy = %@\n",
            [self answerByType:OTStudentSubjectTypeBiology],
            [self answerByType:OTStudentSubjectTypeMath],
            [self answerByType:OTStudentSubjectTypeDevelopment],
            [self answerByType:OTStudentSubjectTypeEngineering],
            [self answerByType:OTStudentSubjectTypeArt],
            [self answerByType:OTStudentSubjectTypePhycology],
            [self answerByType:OTStudentSubjectTypeAnatomy]];
}


- (NSString *)descriptionLevel1 {
    return [NSString stringWithFormat:  @"\nStudent studies:\n"
                                        "biology = %@\n"
                                        "math = %@\n"
                                        "development = %@\n"
                                        "engineering = %@\n"
                                        "art = %@\n"
                                        "phycology = %@\n"
                                        "anatomy = %@\n",
                                        self.studiesBiology ? @"YES" : @"NO",
                                        self.studiesMath ? @"YES" : @"NO",
                                        self.studiesDevelopment ? @"YES" : @"NO",
                                        self.studiesEngineering ? @"YES" : @"NO",
                                        self.studiesArt ? @"YES" : @"NO",
                                        self.studiesPhycology ? @"YES" : @"NO",
                                        self.studiesAnatomy ? @"YES" : @"NO"];
}

- (NSString *)answerByType:(OTStudentSubjectType) type {
    return self.subjectType & type ? @"yes" : @"no";
}

@end
