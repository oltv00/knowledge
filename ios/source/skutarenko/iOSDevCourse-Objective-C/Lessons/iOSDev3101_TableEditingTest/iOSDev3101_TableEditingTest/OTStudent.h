//
//  OTStudent.h
//  iOSDev3101_TableEditingTest
//
//  Created by Oleg Tverdokhleb on 26.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTStudent : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastname;
@property (assign, nonatomic) double averageGrade;

+ (OTStudent *)randomStudent;

@end
