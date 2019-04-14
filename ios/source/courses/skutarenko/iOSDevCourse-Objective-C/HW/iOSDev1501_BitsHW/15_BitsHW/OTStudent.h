//
//  OTStudent.h
//  15_BitsHW
//
//  Created by Oleg Tverdokhleb on 09.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, OTStudentSubjectType) {
    OTStudentSubjectTypeBiology         = 1 << 0,
    OTStudentSubjectTypeMath            = 1 << 1,
    OTStudentSubjectTypeDevelopment     = 1 << 2,
    OTStudentSubjectTypeEngineering     = 1 << 3,
    OTStudentSubjectTypeArt             = 1 << 4,
    OTStudentSubjectTypePhycology       = 1 << 5,
    OTStudentSubjectTypeAnatomy         = 1 << 6
};

@interface OTStudent : NSObject

@property (assign, nonatomic) OTStudentSubjectType subjectType;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastName;

- (NSString *)descriptionStudent;

@end
