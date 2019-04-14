//
//  OLTVStudent.h
//  iOSDev4001_KVCHW
//
//  Created by Oleg Tverdokhleb on 18.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

typedef NS_ENUM(NSInteger, OLTVStudentGender){
  OLTVStudentGenderMale,
  OLTVStudentGenderFemale
};

@interface OLTVStudent : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSDate *dateOfBirth;
@property (assign, nonatomic) OLTVStudentGender gender;
@property (assign, nonatomic) CGFloat averageGrade;

@end
