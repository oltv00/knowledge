//
//  MSMStudent.h
//  SearchHomeWork
//
//  Created by Admin on 27.02.14.
//  Copyright (c) 2014 Sergey Monastyrskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSInteger studentsCount = 30;

@interface MSMStudent : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSDate *birthdate;
@property (assign, nonatomic) NSUInteger birthdateMonth;

+ (MSMStudent *)createNewStudent;

@end
