//
//  ASDataArray.m
//  HW_36_UIPopoverController
//
//  Created by MD on 04.07.15.
//  Copyright (c) 2015 hh. All rights reserved.
//

#import "ASDataArray.h"

@implementation ASDataArray

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.educationArray = [NSArray arrayWithObjects:@"Preschool",               @"Kindergarten",       @"Nursery",
                                                        @"Play school",             @"Elementary school",  @"Middle school",
                                                        @"Comprehensive school",    @"Secondary school",   @"College",
                                                        @"Institute of technology", @"University",         @"Public university",nil];
        
    }
    return self;
}
@end
