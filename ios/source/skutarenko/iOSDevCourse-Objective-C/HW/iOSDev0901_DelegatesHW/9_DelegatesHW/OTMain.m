//
//  OTMain.m
//  9_DelegatesHW
//
//  Created by Oleg Tverdokhleb on 02.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTMain.h"
#import "OTPatient.h"
#import "OTDoctor.h"
#import "OTFriend.h"

@implementation OTMain

#pragma mark - LifeCycle

- (void)main {
//    [self startTests];
//    [self levelNoob];
//    [self levelStudent];
//    [self levelMaster];
    [self levelSuperman];
}

- (void)levelSuperman {
    NSMutableArray *patients = [NSMutableArray array];
    OTDoctor *doctor1 = [[OTDoctor alloc] initWithName:@"JOHN"];
    OTDoctor *doctor2 = [[OTDoctor alloc] initWithName:@"SMITH"];
    /*
     *      SET THE PATIENTS COUNT!
     */
    for (int patientsCount = 0; patientsCount < 100; patientsCount++) {
        OTPatient *patient = [[OTPatient alloc] initWithPatientID:[NSString stringWithFormat:@"%d", patientsCount]];
        patient.delegate = doctor1;
        [patients addObject:patient];
    }
    /*
     *      SET THE DAYS COUNT!
     */
    for (int dayCount = 1; dayCount <= 10; dayCount++) {
        [self day:dayCount withDoctors:doctor1 Doctor2:doctor2 Patients:patients];
    }
}

- (void)day:(NSInteger)day withDoctors:(OTDoctor *)doctor1
               Doctor2:(OTDoctor *)doctor2
              Patients:(NSMutableArray *)patients {
    NSLog(@"----------------------------------");
    NSLog(@"DAY = %ld", day);
    NSLog(@"----------------------------------");

    for (OTPatient *patient in patients) {
        [patient feelsBad];
    }
    
    [doctor1 report];
    [doctor2 report];
    
    for (OTPatient *patient in patients) {
        if (patient.doctorRating < 50) {
            patient.doctorRating = 100;
            patient.delegate = doctor2;
            
            [doctor1.patients removeObjectForKey:patient.patientID];
            [doctor2.patients setObject:patient forKey:patient.patientID];
        }
    }
    NSLog(@"%@ HAVE %ld PATIENTS", doctor1.name, doctor1.numberOfPatients);
    NSLog(@"%@ HAVE %ld PATIENTS", doctor2.name, doctor2.numberOfPatients);
}

- (void)levelMaster {
    OTDoctor *doctor = [OTDoctor new];
    for (int i = 0; i < 100; i++) {
        OTPatient *patient = [OTPatient new];
        patient.delegate = doctor;
        [patient feelsBad];
    }
    [doctor report];
}

- (void)levelStudent {
    OTDoctor *doctor = [OTDoctor new];
    OTFriend *friend = [OTFriend new];
    for (int i = 0; i < 100; i++) {
        OTPatient *patient = [OTPatient new];
        patient.delegate = arc4random() % 2 ? doctor : friend;
        [patient feelsBad];
    }
}

- (void)levelNoob {
    NSMutableArray *patients = [NSMutableArray array];
    
    OTDoctor *doctor = [[OTDoctor alloc] init];
    
    for (int i = 0; i < 20; i++) {
        OTPatient *patient = [[OTPatient alloc] init];
        patient.delegate = doctor;
        [patients addObject:patient];
    }
    
    for (OTPatient *patient in patients) {
//        NSLog(@"%@ %@ %.1f", patient.name, patient.lastName, patient.temperature);
        [patient feelsBad];
    }
}

#pragma mark - TESTS

- (void)startTests {
    //    [self randTest];
    //    [self arctest];
//    [self dictsTest];
}

- (void)dictsTest {
    NSDictionary *dict1 = @{@"key" : @"value",
                            @"key2" : @"value2",
                            @"key" : @"123value"};
    NSLog(@"%@", dict1);
}

- (void)arctest {
    int yes = 0;
    int no = 0;
    for (int i = 0; i < 1000000; i++) {
        //        NSLog(@"%d", arc4random() % 2);
        if (arc4random() % 2 == YES) {
            yes += 1;
        } else {
            no += 1;
        }
    }
    NSLog(@"YES = %d, NO = %d", yes, no);
}

- (void)randTest {
    for (int i = 0; i < 50; i ++) {
        float randomNum = 36.6 + ((float)rand() / RAND_MAX) * 4.4;
        NSLog(@"%f", randomNum);
    }
}

@end
