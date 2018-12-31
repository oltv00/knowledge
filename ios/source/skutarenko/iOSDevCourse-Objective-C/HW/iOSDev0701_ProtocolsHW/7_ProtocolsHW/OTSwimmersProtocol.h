//
//  SwimmersProtocol.h
//  7_ProtocolsHW
//
//  Created by Oleg Tverdokhleb on 01.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTMain.h"

@protocol OTSwimmersProtocol <NSObject>

@required
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) NSInteger speedOfSwimming;

- (void)swim;

@optional
@property (assign, nonatomic) NSInteger speedRun;
@property (assign, nonatomic) NSInteger heightOfTheJump;

- (void)run;
- (void)jump;

@end
