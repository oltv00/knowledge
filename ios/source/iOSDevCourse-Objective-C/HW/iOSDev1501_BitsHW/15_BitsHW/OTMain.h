//
//  OTMain.h
//  15_BitsHW
//
//  Created by Oleg Tverdokhleb on 09.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTMain : NSObject

+ (OTMain *)sharedMain;
- (void)main;

@end
