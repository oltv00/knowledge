//
//  OTStudent.m
//  7_ProtocolsTest
//
//  Created by Oleg Tverdokhleb on 31.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTStudent.h"

@implementation OTStudent

- (void)study {
    
}

#pragma mark - OTPatientProtocol

- (BOOL)areYouOk {
    BOOL ok = arc4random() % 2;
    NSLog(@"Is Student %@ ok? %@", self.name, ok ? @"YES" : @"NO");
    return ok;
}

- (void)takePill {
    NSLog(@"Student %@ takes a pill", self.name);
}
- (void)makeShot {
    NSLog(@"Student %@ makes a shot", self.name);
}

- (NSString *)howIsYourFamily {
    return @"My family is doing well";
}

@end
