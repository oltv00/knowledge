//
//  OTDancer.m
//  7_ProtocolsTest
//
//  Created by Oleg Tverdokhleb on 31.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTDancer.h"

@implementation OTDancer

- (void)dance {
    
}

#pragma mark - OTPatientProtocol

- (BOOL)areYouOk {
    BOOL ok = arc4random() % 2;
    NSLog(@"Is Dancer %@ ok? %@", self.name, ok ? @"YES" : @"NO");
    return ok;
}

- (void)takePill {
    NSLog(@"Dancer %@ takes a pill", self.name);
}
- (void)makeShot {
    NSLog(@"Dancer %@ makes a shot", self.name);
}

@end
