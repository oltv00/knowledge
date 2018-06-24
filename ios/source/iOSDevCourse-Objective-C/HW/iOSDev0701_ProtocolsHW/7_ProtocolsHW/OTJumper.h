//
//  Cyclist.h
//  5_Arrays
//
//  Created by Oleg Tverdokhleb on 29.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTPerson.h"
#import "OTJumpersProtocol.h"

@interface OTJumper : OTPerson <OTJumpersProtocol>

@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) NSInteger heightOfTheJump;

- (instancetype)initWithName:(NSString *) name Index:(NSInteger)index;

@end
