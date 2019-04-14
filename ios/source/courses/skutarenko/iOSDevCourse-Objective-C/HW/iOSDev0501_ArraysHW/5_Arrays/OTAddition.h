//
//  OTAddition.h
//  5_Arrays
//
//  Created by Oleg Tverdokhleb on 29.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTPerson.h"

@interface OTAddition : OTPerson

@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *education;
@property (assign, nonatomic) NSInteger age;

- (void)aboutAddition;

@end
