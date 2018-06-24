//
//  MRQStudent.m
//  7_ProtocolsTest
//
//  Created by Oleg Tverdokhleb on 11.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQStudent.h"

@implementation MRQStudent

- (void) study {
    
}

#pragma mark - MRQPatient

- (BOOL) areYouOK{
    BOOL ok = arc4random() % 2;
    NSLog(@"Is Student %@ ok? %@", self.name, ok ? @"YES" : @"NO");
    return ok;
}

- (void) takePill{
    NSLog(@"Student %@ takes a pill", self.name);
}

- (void) makeShot{
    NSLog(@"Student %@ makes a short", self.name);
}

- (NSString*) howIsYourFamily{
    return @"My family is doing well!";
}

@end
