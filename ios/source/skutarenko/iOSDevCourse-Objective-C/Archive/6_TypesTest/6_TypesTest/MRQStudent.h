//
//  MRQStudent.h
//  6_TypesTest
//
//  Created by Oleg Tverdokhleb on 10.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  enum {
    
    MRQGenderMale, // = 0
    MRQGenderFemale // = 1

} MRQGender;

//typedef NSString MRQTaburetka;

@interface MRQStudent : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) MRQGender gender;

@end
