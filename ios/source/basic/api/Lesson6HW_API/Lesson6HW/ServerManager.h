//
//  ServerManager.h
//  Lesson6HW
//
//  Created by Oleg Tverdokhleb on 25.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServerManagerDelegate;

@interface ServerManager : NSObject

@property (weak, nonatomic) id <ServerManagerDelegate> delegate;

+ (ServerManager *)managerWithDelegate:(id <ServerManagerDelegate>) delegate;

@end

@protocol ServerManagerDelegate <NSObject>

@required
- (void)getAdvice:(id)advice;

@end