//
//  ParentClass.m
//  1_FunctionsTest
//
//  Created by Oleg Tverdokhleb on 04.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ParentClass.h"

@implementation ParentClass

+ (void) selfOfParentClass {
    NSLog(@"Self of ParentClass: %@", self);
}
- (void) selfOfMethodParentClass {
    NSLog(@"Self of method ParentClass: %@", self);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"Instance of Parent class is created!");
    }
    return self;
}

+ (void) whoAreYou {
    NSLog(@"I AM ParentClass %@", self);
}

- (void) sayHello {
    NSLog(@"Parent says hello! %@", self);
}

- (void) say:(NSString*) string {
    NSLog(@"%@", string);
}

- (void) say:(NSString*) string and:(NSString*) string2 {
    NSLog(@"%@, %@", string, string2);
}

- (void) say:(NSString*) string and:(NSString*) string2 andAfterThat:(NSString*) string3 {
    NSLog(@"%@, %@, %@", string, string2, string3);
}

//Скрытый метод под инкапсуляцией
- (NSString*) saySomeNumberString {
    return [NSString stringWithFormat:@"%@", [NSDate date]];
}

- (NSString*) saySomething {
    return [self saySomeNumberString];
}

@end
