//
//  AZStudent.h
//  AZSearch
//
//  Created by Alex Alexandrov on 12.02.14.
//  Copyright (c) 2014 Alex Zbirnik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZStudent : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSDate *birthDay;
@property (assign, nonatomic) NSRange firstNameSearchChar;
@property (assign, nonatomic) NSRange lastNameSearchChar;

+ (NSDate *) createBirthDay;
- (NSInteger) getBirthDayMonth;

@end
