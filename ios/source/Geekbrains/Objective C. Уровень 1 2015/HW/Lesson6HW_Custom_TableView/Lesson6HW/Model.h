//
//  Model.h
//  Lesson6HW
//
//  Created by Oleg Tverdokhleb on 06.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *descr;

+ (NSArray *)initWithFirstLaunch;

@end
