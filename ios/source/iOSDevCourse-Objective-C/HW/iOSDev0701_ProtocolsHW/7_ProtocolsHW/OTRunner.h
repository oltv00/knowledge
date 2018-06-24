//
//  OTRunner.h
//  5_Arrays
//
//  Created by Oleg Tverdokhleb on 29.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTPerson.h"
#import "OTRunnersProtocol.h"

@interface OTRunner : OTPerson <OTRunnersProtocol>

@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) NSInteger speedRun;

- (instancetype)initWithName:(NSString *) name Index:(NSInteger)index;

@end
