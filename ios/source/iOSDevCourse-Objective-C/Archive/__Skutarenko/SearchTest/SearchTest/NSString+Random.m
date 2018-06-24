//
//  NSString+Random.m
//  SearchTest
//
//  Created by Oleksii Skutarenko on 03.01.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import "NSString+Random.h"

@implementation NSString (Random)


+ (NSString *)randomAlphanumericString {
    
    int length = arc4random() % 11 + 5;
    
    return [self randomAlphanumericStringWithLength:length];
}

+ (NSString *)randomAlphanumericStringWithLength:(NSInteger)length
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyz";//ABCDEFGHIJKLMNOPQRSTUVWXYZ"; //0123456789
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (int i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    
    return randomString;
}

@end
