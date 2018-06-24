//
//  OTStudent.h
//  15_BitsTest
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

- (NSString *)descriptionLevel1;
- (NSString *)descriptionLevel2;

@property (assign, nonatomic) OTStudentSubjectType subjectType;

@property (assign, nonatomic) BOOL studiesBiology;
@property (assign, nonatomic) BOOL studiesMath;
@property (assign, nonatomic) BOOL studiesDevelopment;
@property (assign, nonatomic) BOOL studiesEngineering;
@property (assign, nonatomic) BOOL studiesArt;
@property (assign, nonatomic) BOOL studiesPhycology;
@property (assign, nonatomic) BOOL studiesAnatomy;

@end
