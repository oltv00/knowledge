//
//  NSString+Random.h
//  SearchTest
//
//  Created by Oleksii Skutarenko on 03.01.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Random)

+ (NSString *)randomAlphanumericString;
+ (NSString *)randomAlphanumericStringWithLength:(NSInteger)length;

@end
