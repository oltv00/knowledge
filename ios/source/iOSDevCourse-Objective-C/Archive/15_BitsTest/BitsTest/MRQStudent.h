//
//  MRQStudent.h
//  BitsTest
//
//  Created by Oleg Tverdokhleb on 25.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {

    MRQStudentSubjectTypeBiology        = 1 << 0,
    MRQStudentSubjectTypeMath           = 1 << 1,
    MRQStudentSubjectTypeDevelopment    = 1 << 2,
    MRQStudentSubjectTypeEngineering    = 1 << 3,
    MRQStudentSubjectTypeArt            = 1 << 4,
    MRQStudentSubjectTypePhycology      = 1 << 5,
    MRQStudentSubjectTypeAnatomy        = 1 << 6
    
} MRQStudentSubjectType;



@interface MRQStudent : NSObject

@property (assign, nonatomic) MRQStudentSubjectType subjectType;


/*
@property (assign, nonatomic) BOOL studiesBiology;
@property (assign, nonatomic) BOOL studiesMath;
@property (assign, nonatomic) BOOL studiesDevelopment;
@property (assign, nonatomic) BOOL studiesEngineering;
@property (assign, nonatomic) BOOL studiesArt;
@property (assign, nonatomic) BOOL studiesPhycology;
@property (assign, nonatomic) BOOL studiesAnatomy;
*/
@end
