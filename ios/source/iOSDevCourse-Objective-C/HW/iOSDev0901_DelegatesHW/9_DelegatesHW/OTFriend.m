//
//  OTFriend.m
//  9_DelegatesHW
//
//  Created by Oleg Tverdokhleb on 02.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTFriend.h"

@implementation OTFriend

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"Friend";
    }
    return self;
}

#pragma mark - OTPatientDelegate

-(void)patientFeelsBad:(OTPatient *)patient {
    if (!patient.isPatient) {
        NSLog(@"Hello my dear friend %@ %@, you have temperature %.1f", patient.name, patient.lastName, patient.temperature);
    } else {
        NSLog(@"%@ %@ not better with temperature = %1.1f", patient.name, patient.lastName, patient.temperature);
    }
    
    if (patient.temperature >= 39.f) {
        NSLog(@"Take 50 gram of vodka");
//        [patient howAreYou];
    } else if (patient.temperature < 39.f && patient.temperature >= 37.2f) {
        NSLog(@"Use popular method");
//        [patient howAreYou];
    } else {
        [patient shouldRest];
    }
}

@end
