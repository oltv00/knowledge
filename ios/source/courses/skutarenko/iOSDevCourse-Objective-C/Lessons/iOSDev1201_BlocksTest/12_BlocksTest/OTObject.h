//
//  OTObject.h
//  12_BlocksTest
//
//  Created by Oleg Tverdokhleb on 05.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ObjectBlock)(void);

@interface OTObject : NSObject

@property (strong, nonatomic) NSString *name;

- (void)method:(ObjectBlock)block;

@end
