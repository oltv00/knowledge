//
//  OTPatient.m
//  9_DelegatesTest
//
//  Created by Oleg Tverdokhleb on 02.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTPatient.h"

@implementation OTPatient

- (BOOL)howAreYou {
    BOOL isGood = arc4random() % 2;
    if (!isGood) {
        [self.delegate patientFeelsBad:self];
    }
    return isGood;
}

- (void)takePill {
    NSLog(@"%@ takes a pill", self.name);
}

- (void)makeShot {
    NSLog(@"%@ make a shot", self.name);
}


@end
