//
//  MRQDancer.h
//  7_ProtocolsTest
//
//  Created by Oleg Tverdokhleb on 11.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRQPatient.h"

@interface MRQDancer : NSObject <MRQPatient>

@property (nonatomic, strong) NSString *favouriteDance;
@property (nonatomic, strong) NSString *name;

- (void) dance;

@end
