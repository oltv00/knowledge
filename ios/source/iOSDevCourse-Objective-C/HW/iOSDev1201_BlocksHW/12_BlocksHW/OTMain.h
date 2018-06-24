//
//  OTMain.h
//  12_BlocksHW
//
//  Created by Oleg Tverdokhleb on 06.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTMain : NSObject

+ (OTMain *)sharedMain;
- (void)main;

@end
