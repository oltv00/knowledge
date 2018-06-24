//
//  MRQParentClass.h
//  2_FunctionsTest
//
//  Created by Oleg Tverdokhleb on 29.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRQParentClass : NSObject

@property (strong, nonatomic) NSString *name;

+ (void)whoAreYou;

- (instancetype)initWithName:(NSString *) name;
- (void)sayHello;
- (void)say:(NSString *) string;
- (void)sayFirst:(NSString *) first andSecond:(NSString *) second;
- (NSString *)saySomething;

@end
