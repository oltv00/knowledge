//
//  MRQJumpers.h
//  7_ProtocolsTestRestoProg
//
//  Created by Oleg Tverdokhleb on 19.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JumpersProtocol.h"
#import "MRQEnums.h"

@interface MRQJumpers : NSObject <JumpersProtocol>

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) CGFloat velocity;
@property (assign, nonatomic) CGFloat maxJumpHeight;
@property (assign, nonatomic) Gender gender;
@property (assign, nonatomic) Occupation occupation;

- (void) jump;
- (void) workout;
- (void) run;
- (void) objectInfo;

@end
