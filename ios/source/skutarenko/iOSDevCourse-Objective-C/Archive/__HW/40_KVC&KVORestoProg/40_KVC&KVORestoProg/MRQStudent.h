//
//  MRQStudent.h
//  40_KVC&KVORestoProg
//
//  Created by Oleg Tverdokhleb on 27.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MRQStudentGender) {
    
    MRQStudentGenderMale,
    MRQStudentGenderFemale
    
};

@interface MRQStudent : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSDate *dateOfBirth;
@property (assign, nonatomic) MRQStudentGender gender;
@property (strong, nonatomic) NSString *grade;

+ (MRQStudent *) addNewStudent;

@end
