//
//  OTMain.m
//  10_NoficationsHW
//
//  Created by Oleg Tverdokhleb on 03.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTMain.h"

@implementation OTMain

#pragma mark - LifeCycle

+ (OTMain *)sharedMain {
    static OTMain *main = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        main = [OTMain new];
    });
    return main;
}

- (void)main {
    [self setup];
}

- (void)setup {
    
}

@end
