//
//  ASObject.m
//  CoreDataTest
//
//  Created by Oleksii Skutarenko on 01.02.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import "ASObject.h"


@implementation ASObject


- (BOOL)validateForDelete:(NSError **)error {
    NSLog(@"%@ validateForDelete", NSStringFromClass([self class]));
    
    return YES;
}

@end
