//
//  ChildClass.m
//  1_FunctionsTest
//
//  Created by Oleg Tverdokhleb on 04.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ChildClass.h"

@implementation ChildClass

+ (void) selfOfChildClass {
    NSLog(@"Self of ChildClass: %@", self);
}
- (void) selfOfMethodChildClass {
    NSLog(@"Self of method ChildClass: %@", self);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"Instance of Child class is created!");
    }
    return self;
}

- (NSString*) saySomeNumberString {
    return @"Something!";
}

- (NSString*) saySomething {
    [super saySomeNumberString];
    return @"Something";
}

@end
