//
//  Auto.h
//  Lesson5HW
//
//  Created by Oleg Tverdokhleb on 06.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Auto : NSObject

@property (strong, nonatomic) NSString *model;
@property (strong, nonatomic) NSString *engine;

+ (Auto *) initialize;

@end
