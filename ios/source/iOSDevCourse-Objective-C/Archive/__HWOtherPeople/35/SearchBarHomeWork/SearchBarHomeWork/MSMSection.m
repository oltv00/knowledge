//
//  MSMSection.m
//  SearchBarHomeWork
//
//  Created by Admin on 05.03.14.
//  Copyright (c) 2014 Sergey Monastyrskiy. All rights reserved.
//

#import "MSMSection.h"

@implementation MSMSection

- (NSString *)description
{
    NSString *sectionDescribe = [NSString stringWithFormat:@"index = %@, rows = %@", self.index, self.rowsArray];
    
    return sectionDescribe;
}

@end
