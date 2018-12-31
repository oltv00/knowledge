//
//  OTStudent.h
//  6_TypesTest
//
//  Created by Oleg Tverdokhleb on 30.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, OTGender) {
    OTGenderMale,
    OTGenderFemale
};

@interface OTStudent : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) OTGender gender;

@end
