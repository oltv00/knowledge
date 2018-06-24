//
//  OTBoxer.m
//  7_ProtocolsTest
//
//  Created by Oleg Tverdokhleb on 31.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTDeveloper.h"

@implementation OTDeveloper

- (void)work {
    
}

#pragma mark - OTPatientProtocol

- (BOOL)areYouOk {
    BOOL ok = arc4random() % 2;
    NSLog(@"Is Developer %@ ok? %@", self.name, ok ? @"YES" : @"NO");
    return ok;
}

- (void)takePill {
    NSLog(@"Developer %@ takes a pill", self.name);
}
- (void)makeShot {
    NSLog(@"Developer %@ makes a shot", self.name);
}

- (NSString *)howIsYourJob {
    return @"My job is awesome!";
}

@end
