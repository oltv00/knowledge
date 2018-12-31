//
//  OTMain.m
//  8_DictionaryTest
//
//  Created by Oleg Tverdokhleb on 01.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTMain.h"

@implementation OTMain

- (void)main {
    [self testOne];
    [self testTwo];
}

- (void)testTwo {
    NSDictionary *dict = @{
                           @"name" : @"Vasiliy" ,
                           @"lastName" : @"Petrov",
                           @"age" : @25
                           };
    NSLog(@"%@", dict);
    
    NSLog(@"name = %@, lastName = %@, age = %ld", dict[@"name"], dict[@"lastName"], [dict[@"age"] integerValue]);
    
    for (NSString *key in [dict allKeys]) {
        id obj = dict[key];
        NSLog(@"key = %@, value = %@", key, obj);
    }
}

- (void)testOne {
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"Petrov", @"lastName",
                                @"Vasiliy", @"name",
                                @25, @"age", nil];
    NSLog(@"%@", dictionary);
    
    NSString *name = [dictionary objectForKey:@"name"];
    NSString *lastName = [dictionary objectForKey:@"lastName"];
    NSInteger age = [[dictionary objectForKey:@"age"] integerValue];
    NSLog(@"name = %@, lastName = %@, age = %ld", name, lastName, age);
    
    for (NSString *key in [dictionary allKeys]) {
        id obj = [dictionary objectForKey:key];
        NSLog(@"key = %@, value = %@", key, obj);
    }
}

@end
