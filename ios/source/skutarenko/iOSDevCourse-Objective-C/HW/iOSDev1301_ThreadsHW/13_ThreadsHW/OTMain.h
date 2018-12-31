//
//  OTMain.h
//  13_ThreadsHW
//
//  Created by Oleg Tverdokhleb on 07.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OTMain : NSObject

+ (OTMain *)sharedMain;
- (void)main;

@end
