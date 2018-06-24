//
//  MRQDelegObject.m
//  Lesson4HW
//
//  Created by Oleg Tverdokhleb on 06.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQDelegObject.h"

@implementation MRQDelegObject

-(void)sendMessage {
    
    NSLog(@"sendMessage in class %@", self);
    NSString *message = @"DELEGATE";
    if ([self.delegate respondsToSelector:@selector(objectWasSendMessage:)]) {
        [self.delegate objectWasSendMessage:message];
    }
}

@end
