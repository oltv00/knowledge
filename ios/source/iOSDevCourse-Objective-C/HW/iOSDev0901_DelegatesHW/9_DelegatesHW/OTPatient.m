//
//  OTPatient.m
//  9_DelegatesHW
//
//  Created by Oleg Tverdokhleb on 02.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTPatient.h"
#import "Data.h"

@implementation OTPatient

- (instancetype)initWithPatientID:(NSString *)patientID
{
    self = [super init];
    if (self) {
        self.name = firstNames[arc4random_uniform(50)];
        self.lastName = lastNames[arc4random_uniform(50)];
        self.temperature = 36.6 + ((float)rand() / RAND_MAX) * 4.4;
        self.isPatient = NO;
        self.indexOfBodyPart = arc4random_uniform(4);
        self.doctorRating = 100;
        self.patientID = patientID;
        
        switch (self.indexOfBodyPart) {
            case OTPatientBodyPartHead:
                self.bodyPart = @"head";
                break;
            case OTPatientBodyPartHand:
                self.bodyPart = @"hand";
                break;
            case OTPatientBodyPartBelly:
                self.bodyPart = @"belly";
                break;
            case OTPatientBodyPartLeg:
                self.bodyPart = @"leg";
                break;
            default:
                NSLog(@"PATIENT INIT WARNING");
                break;
        }
    }
    return self;
}

- (void)feelsBad {
    [self.delegate patientFeelsBad:self];
}

- (void)takePill {
    NSLog(@"%@ %@ take a pill", self.name, self.lastName);
}

- (void)makeShot {
    NSLog(@"%@ %@ make a shot", self. name, self.lastName);
}

- (void)shouldRest {
    NSLog(@"Patient %@ %@ should rest", self.name, self.lastName);
    NSLog(@"-------------------------------------------");
}

- (void)cureFromBodyPart {
    NSLog(@"%@ %@ take a cure from %@", self.name, self.lastName, self.bodyPart);
}

@end
