//
//  Object.h
//  Lesson4HW
//
//  Created by Oleg Tverdokhleb on 05.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//



#import <Foundation/Foundation.h>

#define     NOTIFICATION_KEY                @"resultString"
#define     ObjectNotificationWillPost      @"ObjectNotificationWillPost"

@interface MRQNotifObject : NSObject

- (void) postNotification;

@end
