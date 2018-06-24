//
//  MRQObject.h
//  12_BlocksTest
//
//  Created by Oleg Tverdokhleb on 24.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ObjectBlock)(void);

@interface MRQObject : NSObject

@property (strong, nonatomic) NSString *name;


- (void) testMethod:(ObjectBlock) block;
@end
