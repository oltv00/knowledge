//
//  RunnersProtocol.h
//  7_ProtocolsTestRestoProg
//
//  Created by Oleg Tverdokhleb on 19.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RunnersProtocol <NSObject>

@required

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) CGFloat velocity;
@property (assign, nonatomic) CGFloat maxRunDist;

- (void) run;
- (void) workout;
- (void) objectInfo;

@optional

@property (assign, nonatomic) CGFloat maxJumpHeight;
@property (assign, nonatomic) CGFloat maxSwimDist;

- (void) swim;
- (void) jump;

@end