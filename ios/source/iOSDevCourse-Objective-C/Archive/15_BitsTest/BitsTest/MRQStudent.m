//
//  MRQStudent.m
//  BitsTest
//
//  Created by Oleg Tverdokhleb on 25.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQStudent.h"

@implementation MRQStudent

- (NSString*) answerByType:(MRQStudentSubjectType) type {
    return self.subjectType & type ? @"yes" : @"no";
}

- (NSString*) description {
    
    return [NSString stringWithFormat:  @"Student studies:\n"
            "biology = %@\n"
            "math = %@\n"
            "development = %@\n"
            "engineering = %@\n"
            "art = %@\n"
            "phycology = %@\n"
            "anatomy = %@",
            [self answerByType:MRQStudentSubjectTypeBiology],
            [self answerByType:MRQStudentSubjectTypeMath],
            [self answerByType:MRQStudentSubjectTypeDevelopment],
            [self answerByType:MRQStudentSubjectTypeEngineering],
            [self answerByType:MRQStudentSubjectTypeArt],
            [self answerByType:MRQStudentSubjectTypePhycology],
            [self answerByType:MRQStudentSubjectTypeAnatomy]];
}


/*
- (NSString*) description {
 
    return [NSString stringWithFormat:  @"Student studies:\n"
                                        "biology = %@\n"
                                        "math = %@\n"
                                        "development = %@\n"
                                        "engineering = %@\n"
                                        "art = %@\n"
                                        "phycology = %@\n"
                                        "anatomy = %@",
                                        self.studiesBiology ? @"yes" : @"no",
                                        self.studiesMath ? @"yes" : @"no",
                                        self.studiesDevelopment ? @"yes" : @"no",
                                        self.studiesEngineering ? @"yes" : @"no",
                                        self.studiesArt ? @"yes" : @"no",
                                        self.studiesPhycology ? @"yes" : @"no",
                                        self.studiesAnatomy ? @"yes" : @"no"];
}
*/
@end
