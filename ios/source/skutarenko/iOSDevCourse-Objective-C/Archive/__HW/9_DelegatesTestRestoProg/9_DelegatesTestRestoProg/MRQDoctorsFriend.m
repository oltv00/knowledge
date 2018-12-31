//
//  MRQDoctorsFriend.m
//  9_DelegatesTestRestoProg
//
//  Created by Oleg Tverdokhleb on 24.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQDoctorsFriend.h"

@implementation MRQDoctorsFriend

- (void) patientFeelsBad:(MRQPatient*) patient {
    
    NSLog(@"Patient name: %@", patient.name);
    
    if (patient.temperature >= 41.f){
        [patient makeTheSurgery];
    } else
        if (patient.temperature <= 41.f && patient.temperature >= 38.f){
            [patient makeShot];
        } else
            if (patient.temperature <= 38.f && patient.temperature >= 37.f){
                [patient takePill];
            } else
                if (patient.temperature <= 37.f){
                    [patient theRest];
                }
    
}

- (void) patient:(MRQPatient*) patient hasQuestion:(NSString*) question {
    NSLog(@"Patietn %@ has a question %@", patient.name, question);
}

@end
