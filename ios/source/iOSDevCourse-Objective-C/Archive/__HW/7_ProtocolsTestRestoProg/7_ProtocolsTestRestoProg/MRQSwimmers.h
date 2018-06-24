//
//  MRQSwimmers.h
//  7_ProtocolsTestRestoProg
//
//  Created by Oleg Tverdokhleb on 19.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SwimmersProtocol.h"
#import "MRQEnums.h"

@interface MRQSwimmers : NSObject <SwimmersProtocol>

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) CGFloat velocity;
@property (assign, nonatomic) CGFloat maxSwimDist;
@property (assign, nonatomic) Gender gender;

- (void) swim;
- (void) workout;
- (void) greeting;


@end
