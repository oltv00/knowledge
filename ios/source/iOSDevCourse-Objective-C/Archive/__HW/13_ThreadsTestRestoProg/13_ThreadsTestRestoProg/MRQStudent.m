//
//  MRQStudent.m
//  13_ThreadsTestRestoProg
//
//  Created by Oleg Tverdokhleb on 25.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQStudent.h"

@implementation MRQStudent

- (void) guessTheAnswer:(NSInteger) intValue studentAnswer:(NSInteger) studentAnswer {
    if (intValue == studentAnswer){
        NSLog(@"Student %@ is right! The value is %d", self.name, intValue);
    }
}

@end
