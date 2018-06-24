//
//  SingleTone.m
//  Lesson1-segues
//
//  Created by Oleg Tverdokhleb on 12.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "SingleTone.h"

@implementation SingleTone

+ (SingleTone *) sharedSingleTone {
    
    static SingleTone *singleTone = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        singleTone = [[SingleTone alloc] init];
        
    });
    
    return singleTone;
}

@end
