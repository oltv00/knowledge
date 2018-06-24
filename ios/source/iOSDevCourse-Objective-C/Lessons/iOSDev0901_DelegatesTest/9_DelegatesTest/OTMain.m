//
//  OTMain.m
//  9_DelegatesTest
//
//  Created by Oleg Tverdokhleb on 02.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTMain.h"
#import "OTDoctor.h"
#import "OTPatient.h"

@implementation OTMain

- (void)main {
    OTPatient *patient1 = [[OTPatient alloc] init];
    patient1.name = @"Vova";
    patient1.temperature = 36.6f;
    
    OTPatient *patient2 = [[OTPatient alloc] init];
    patient2.name = @"Petya";
    patient2.temperature = 40.2f;
    
    OTPatient *patient3 = [[OTPatient alloc] init];
    patient3.name = @"Dima";
    patient3.temperature = 37.1f;

    OTPatient *patient4 = [[OTPatient alloc] init];
    patient4.name = @"Sasha";
    patient4.temperature = 38.f;


    OTDoctor *doctor = [[OTDoctor alloc] init];
    
    patient1.delegate = doctor;
    patient2.delegate = doctor;
    patient3.delegate = doctor;
    patient4.delegate = doctor;
    
    NSLog(@"%@ are you ok? %@",patient1.name, [patient1 howAreYou] ? @"Yes":@"No");
    NSLog(@"%@ are you ok? %@",patient2.name, [patient2 howAreYou] ? @"Yes":@"No");
    NSLog(@"%@ are you ok? %@",patient3.name, [patient3 howAreYou] ? @"Yes":@"No");
    NSLog(@"%@ are you ok? %@",patient4.name, [patient4 howAreYou] ? @"Yes":@"No");
}

@end
