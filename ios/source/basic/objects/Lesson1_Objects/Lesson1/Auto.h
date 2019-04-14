//
//  Auto.h
//  Lesson1
//
//  Created by Oleg Tverdokhleb on 29.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, AutoDirection) {
    
    AutoDirectionLeft,
    AutoDirectionRight,
};

@interface Auto : NSObject

@property (strong, nonatomic) NSString *direction;

- (void) driveAuto:(AutoDirection) direction;

@end
