//
//  MRQPatient.m
//  9_DelegatesTestRestoProg
//
//  Created by Oleg Tverdokhleb on 20.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQPatient.h"

@implementation MRQPatient

- (void) conditionWorsened {
    if (self.headache == NO) self.headache = arc4random() % 2;
    if (self.chestPain == NO) self.chestPain = arc4random() % 2;
    self.temperature += 1;
    
    [self howAreYou];
}

- (BOOL) howAreYou {
    BOOL aYouOk = NO; //arc4random() % 2;
    
    if (aYouOk == NO) {
        [self.delegate patientFeelsBad:self];
    }
    return aYouOk;
}

- (void) takePill {
    NSLog(@"Patient %@ takes a pill", self.name);
}

- (void) makeShot {
    NSLog(@"Patient %@ makes a shot", self.name);
}

- (void) makeTheSurgery {
    NSLog(@"Patient %@ had surgery", self.name);
}

- (void) theRest {
    NSLog(@"Patient %@ need to rest", self.name);
}

@end
