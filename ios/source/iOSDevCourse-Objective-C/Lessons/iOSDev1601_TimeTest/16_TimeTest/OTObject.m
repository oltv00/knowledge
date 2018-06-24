//
//  OTObject.m
//  16_TimeTest
//
//  Created by Oleg Tverdokhleb on 09.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTObject.h"

@implementation OTObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@ is initialized", self);
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerTest:) userInfo:nil repeats:YES];
        [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        [timer performSelector:@selector(invalidate) withObject:nil afterDelay:10];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%@ is deallocated", self);
}

- (void)timerTest:(NSTimer *)timer {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss:SSS"];
    NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
}

@end
