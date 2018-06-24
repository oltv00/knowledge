//
//  OTDoctor.m
//  9_DelegatesHW
//
//  Created by Oleg Tverdokhleb on 02.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTDoctor.h"

@implementation OTDoctor

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.patients = [NSMutableDictionary dictionary];
        self.name = name;
    }
    return self;
}

- (void)report {
    NSMutableArray *heads = [NSMutableArray array];
    NSMutableArray *hands = [NSMutableArray array];
    NSMutableArray *bellys = [NSMutableArray array];
    NSMutableArray *legs = [NSMutableArray array];
    
    for (NSString *key in [self.patients allKeys]) {
        switch ([self.patients[key] indexOfBodyPart]) {
            case OTPatientBodyPartHead:
                [heads addObject:self.patients[key]];
                break;
            case OTPatientBodyPartHand:
                [hands addObject:self.patients[key]];
                break;
            case OTPatientBodyPartBelly:
                [bellys addObject:self.patients[key]];
                break;
            case OTPatientBodyPartLeg:
                [legs addObject:self.patients[key]];
                break;
            default:
                break;
        }
    }
    [self printArray:heads withBodyTheme:@"heads"];
    [self printArray:hands withBodyTheme:@"hands"];
    [self printArray:bellys withBodyTheme:@"heads"];
    [self printArray:legs withBodyTheme:@"legs"];
    
    NSInteger sum = heads.count + hands.count + bellys.count + legs.count;
    self.numberOfPatients = sum;
    sum = 0;
}

- (void)printArray:(NSMutableArray *)array withBodyTheme:(NSString *)theme {
    NSLog(@"Attending medical doctor: %@", self.name);
    NSLog(@"Patients with '%@' curing in the amount of %ld", theme, [array count]);
    for (OTPatient *patient in array) {
        NSLog(@"%@ %@", patient.name, patient.lastName);
    }
    NSLog(@"----------------------------------------------------");
}

- (void)askPatientAboutHealth:(OTPatient *)patient {
    NSLog(@"Doctor %@ ask question 'How are you? %@ %@'",self.name, patient.name, patient.lastName);
    BOOL isFeelGood = arc4random() % 2;
    if (!isFeelGood) {
        patient.isPatient = YES;
        patient.temperature = 36.6 + ((float)rand() / RAND_MAX) * 4.4;
        patient.doctorRating -= 25;
        [self patientFeelsBad:patient];
    } else {
        [patient shouldRest];
    }
}

#pragma mark - OTPatientDelegate

- (void)patientFeelsBad:(OTPatient *)patient {
    if (!patient.isPatient) {
        NSLog(@"The doctor %@ has a diagnosis", self.name);
        NSLog(@"%@ %@ feels bad with temperature = %1.1f", patient.name, patient.lastName, patient.temperature);
        NSLog(@"%@ %@ feels bad with body part = %@", patient.name, patient.lastName, patient.bodyPart);
        
        [patient cureFromBodyPart];
        [self.patients setObject:patient forKey:patient.patientID];
    } else {
        NSLog(@"%@ %@ not better with temperature = %1.1f", patient.name, patient.lastName, patient.temperature);
    }
    
    if (patient.temperature >= 39.f) {
        [patient makeShot];
        [self askPatientAboutHealth:patient];
    } else if (patient.temperature < 39.f && patient.temperature >= 37.2f) {
        [patient takePill];
        [self askPatientAboutHealth:patient];
    } else {
        [self askPatientAboutHealth:patient];
    }
}

@end
