//
//  MRQObject.m
//  16_TimeTest
//
//  Created by Oleg Tverdokhleb on 26.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQObject.h"

@interface MRQObject ()

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation MRQObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"MRQObject is initialized");
        
        __weak id weakSelf = self; //НЕ СРАБОТАЕТ! Объект будет жить всегда!
        
        [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerTest:) userInfo:nil repeats:YES];
        
    }
    return self;
}

- (void) timerTest:(NSTimer*) timer {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss:SSS"];
    NSLog(@"%@", [dateFormatter stringFromDate:[NSDate date]]);
}


- (void) dealloc {
    //[self.timer invalidate]; //никогда не сработает! //Нужно делать отдельный метод!
    
    NSLog(@"MRQObject is deallocated");
}
@end
