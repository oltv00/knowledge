//
//  Random.m
//  UITableViewSearchTest
//
//  Created by Oleg Tverdokhleb on 09.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "NSString+Random.h"

@implementation NSString (Random)

+ (NSString *)randomAlphanumericString {
    
    int lenght = arc4random() % 11 + 5;
    
    NSString *string = [self randomAlphanumericStringWithLength:lenght];
    
    return string;
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
