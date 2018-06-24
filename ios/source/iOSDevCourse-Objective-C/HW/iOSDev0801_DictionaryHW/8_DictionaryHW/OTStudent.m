//
//  OTStudent.m
//  8_DictionaryHW
//
//  Created by Oleg Tverdokhleb on 01.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTStudent.h"
#import "Data.h"

@implementation OTStudent

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = firstNames[arc4random_uniform(51)];
        self.lastName = lastNames[arc4random_uniform(51)];
    }
    return self;
}

- (void)greeting {
    NSLog(@"The student %@ %@ says 'Hello!'", self.name, self.lastName);
}

@end
