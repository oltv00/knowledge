//
//  OTObject.m
//  7_ProtocolsTest
//
//  Created by Oleg Tverdokhleb on 31.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTObject.h"
#import "OTStudent.h"
#import "OTDancer.h"
#import "OTDeveloper.h"
#import "OTPatientProtocol.h"

@implementation OTObject

- (void)setup {
    [self first];
}

- (void)first {
    OTDancer *dancer1 = [[OTDancer alloc] init];
    OTDancer *dancer2 = [[OTDancer alloc] init];
    
    OTStudent *student1 = [[OTStudent alloc] init];
    OTStudent *student2 = [[OTStudent alloc] init];
    OTStudent *student3 = [[OTStudent alloc] init];
    
    OTDeveloper *developer1 = [[OTDeveloper alloc] init];
    
    dancer1.name = @"dancer 1";
    dancer2.name = @"dancer 2";
    
    student1.name = @"student 1";
    student2.name = @"student 2";
    student3.name = @"student 3";
    
    developer1.name = @"developer 1";
    
    OTObject *fake = [[OTObject alloc] init];
    
    NSArray *patients = @[fake ,dancer1, developer1, student1, student2, student3, dancer2];
    
    for (id <OTPatientProtocol> patient in patients) {
        
        if ([patient conformsToProtocol:@protocol(OTPatientProtocol)]) {
            NSLog(@"Patient name = %@", patient.name);
            
            if ([patient respondsToSelector:@selector(howIsYourFamily)]) {
                NSLog(@"How is your family?");
                NSLog(@"%@", [patient howIsYourFamily]);
            }
            
            if ([patient respondsToSelector:@selector(howIsYourJob)]) {
                NSLog(@"How is your job?");
                NSLog(@"%@", [patient howIsYourJob]);
            }
            
            if (![patient areYouOk]) {
                [patient takePill];
                if (![patient areYouOk]) {
                    [patient makeShot];
                }
            }
        } else {
            NSLog(@"FAKE!!!");
        }
    }
}





















@end
