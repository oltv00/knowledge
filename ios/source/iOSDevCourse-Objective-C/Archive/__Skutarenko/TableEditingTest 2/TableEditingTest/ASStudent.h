//
//  ASStudent.h
//  TableEditingTest
//
//  Created by Oleksii Skutarenko on 23.12.13.
//  Copyright (c) 2013 Alex Skutarenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASStudent : NSObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (assign, nonatomic) CGFloat averageGrade;

+ (ASStudent*) randomStudent;


@end
