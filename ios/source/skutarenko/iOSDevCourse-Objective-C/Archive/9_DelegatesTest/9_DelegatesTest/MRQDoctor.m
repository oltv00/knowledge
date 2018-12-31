//
//  MRQDoctor.m
//  9_DelegatesTest
//
//  Created by Oleg Tverdokhleb on 14.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQDoctor.h"
#import "MRQPatient.h"

@implementation MRQDoctor





#pragma mark - MRQPatientDelegate

- (void) patientFeelsBad:(MRQPatient*) patient {

    NSLog(@"Patient %@ feels bad", patient.name);
    
    if (patient.temperature >= 37.f && patient.temperature <= 39.f) {
        [patient takePill];
    } else if (patient.temperature > 39.f) {
        [patient makeShot];
    } else {
        NSLog(@"Patient %@ should rest", patient.name);
    }
    
}

- (void) patient:(MRQPatient*) patient hasQuestion:(NSString*) question {
    NSLog(@"Patient %@ has a question %@", patient.name, question);
}

@end
