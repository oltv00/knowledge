//
//  JumpersProtocol.h
//  7_ProtocolsHW
//
//  Created by Oleg Tverdokhleb on 31.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTMain.h"

@protocol OTJumpersProtocol <NSObject>

@required
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) NSInteger heightOfTheJump;

- (void)jump;

@optional
@property (assign, nonatomic) NSInteger speedRun;
@property (assign, nonatomic) NSInteger speedOfSwimming;

- (void)run;
- (void)swim;

@end