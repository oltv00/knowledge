//
//  ASStudent.h
//  TypesTest
//
//  Created by Oleksii Skutarenko on 09.10.13.
//  Copyright (c) 2013 Alex Skutarenko. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    
    ASGenderMale,
    ASGenderFemale
    
} ASGender;



//typedef NSInteger ASTaburetka;


@interface ASStudent : NSObject

@property (strong, nonatomic) NSString* name;

@property (assign, nonatomic) ASGender gender;

@end
