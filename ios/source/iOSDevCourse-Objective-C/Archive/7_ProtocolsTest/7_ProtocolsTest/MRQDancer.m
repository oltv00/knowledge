//
//  MRQDancer.m
//  7_ProtocolsTest
//
//  Created by Oleg Tverdokhleb on 11.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQDancer.h"

@implementation MRQDancer

- (void) dance {

}

#pragma mark - MRQPatient

- (BOOL) areYouOK{
    BOOL ok = arc4random() % 2;
    NSLog(@"Is Dancer %@ ok? %@", self.name, ok ? @"YES" : @"NO");
    return ok;
}

- (void) takePill{
    NSLog(@"Dancer %@ takes a pill", self.name);
}

- (void) makeShot{
    NSLog(@"Dancer %@ makes a short", self.name);
}

@end
