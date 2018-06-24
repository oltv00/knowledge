//
//  MRQRunners.h
//  7_ProtocolsTestRestoProg
//
//  Created by Oleg Tverdokhleb on 19.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RunnersProtocol.h"
#import "MRQEnums.h"

@interface MRQRunners : NSObject <RunnersProtocol>

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) CGFloat velocity;
@property (assign, nonatomic) CGFloat maxRunDist;
@property (assign, nonatomic) Gender gender;

- (void) run;
- (void) workout;
- (void) greeting;

@end
