//
//  MRQDeveloper.m
//  7_ProtocolsTest
//
//  Created by Oleg Tverdokhleb on 11.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQDeveloper.h"

@implementation MRQDeveloper

- (void) work{

}

#pragma mark - MRQPatient

- (BOOL) areYouOK{
    BOOL ok = arc4random() % 2;
    NSLog(@"Is Developer %@ ok? %@", self.name, ok ? @"YES" : @"NO");
    return ok;
}

- (void) takePill{
    NSLog(@"Developer %@ takes a pill", self.name);
}

- (void) makeShot{
    NSLog(@"Developer %@ makes a short", self.name);
}

- (NSString*) howIsYourJob{
    return @"My Job is awesome!";
}

@end
