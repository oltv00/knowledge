//
//  OTSwimmer.h
//  5_Arrays
//
//  Created by Oleg Tverdokhleb on 29.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTPerson.h"
#import "OTSwimmersProtocol.h"

@interface OTSwimmer : OTPerson <OTSwimmersProtocol>

@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) NSInteger speedOfSwimming;
@property (assign, nonatomic) BOOL canRun;
@property (assign, nonatomic) BOOL canJump;

- (instancetype)initWithName:(NSString *) name Index:(NSInteger)index;

@end
