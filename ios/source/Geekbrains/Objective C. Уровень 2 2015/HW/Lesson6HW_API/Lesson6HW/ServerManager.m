//
//  ServerManager.m
//  Lesson6HW
//
//  Created by Oleg Tverdokhleb on 25.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ServerManager.h"

@implementation ServerManager

#pragma mark - Initialize

+ (ServerManager *)managerWithDelegate:(id<ServerManagerDelegate>)delegate {
    return [[ServerManager alloc] initWithDelegate:delegate];
}

- (instancetype)initWithDelegate:(id <ServerManagerDelegate>) delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

#pragma mark - API

- (void)getRandomAdvice {
    
}

@end
