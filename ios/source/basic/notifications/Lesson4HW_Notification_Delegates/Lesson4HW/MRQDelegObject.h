//
//  MRQDelegObject.h
//  Lesson4HW
//
//  Created by Oleg Tverdokhleb on 06.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MRQDelegObjectDelegate;

@interface MRQDelegObject : NSObject

@property (weak, nonatomic) id <MRQDelegObjectDelegate> delegate;

-(void)sendMessage;

@end

@protocol MRQDelegObjectDelegate <NSObject>

@required
-(void)objectWasSendMessage:(NSString *) message;

@end