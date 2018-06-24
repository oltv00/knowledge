//
//  OTStudent.h
//  iOSDev313201_TableViewEditingHW
//
//  Created by Oleg Tverdokhleb on 26.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTStudent : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastname;
@property (assign, nonatomic) double averageScore;

+ (OTStudent *)initRandomStudent;

@end
