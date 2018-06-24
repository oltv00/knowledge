//
//  AZStudent.h
//  HomeProjectTableEditing
//
//  Created by Alex Alexandrov on 11.01.14.
//  Copyright (c) 2014 Alex Zbirnik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZStudent : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) CGFloat averageGrade;

+ (AZStudent *) randomStudent;

@end
