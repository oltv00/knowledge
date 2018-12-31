//
//  OTDoctor.m
//  9_DelegatesTest
//
//  Created by Oleg Tverdokhleb on 02.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTDoctor.h"
#import "OTPatient.h"

@implementation OTDoctor

#pragma mark - OTPatientDelegate

- (void)patientFeelsBad:(OTPatient *)patient {
    NSLog(@"Patient %@ feels bad", patient.name);
    if (patient.temperature >= 37.f && patient.temperature <= 39.f) {
        [patient takePill];
    } else if (patient.temperature >= 39.f) {
        [patient makeShot];
    } else {
        NSLog(@"Patient %@ should rest", patient.name);
    }
}

- (void)patient:(OTPatient *)patient hasQuestion:(NSString *)question {
    NSLog(@"Patient %@ has a question %@", patient.name, question);
}

@end
