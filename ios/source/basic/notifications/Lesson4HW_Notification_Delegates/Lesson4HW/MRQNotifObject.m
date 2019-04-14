//
//  Object.m
//  Lesson4HW
//
//  Created by Oleg Tverdokhleb on 05.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQNotifObject.h"

@implementation MRQNotifObject

-(void)postNotification {
    
    NSLog(@"postNotification in class %@", self);
    NSString *result = @"NOTIFICATION";
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:result
                                                         forKey:NOTIFICATION_KEY];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:ObjectNotificationWillPost
     object:nil
     userInfo:userInfo];
}

@end
