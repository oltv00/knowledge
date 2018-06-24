//
//  OTDoctor.h
//  9_DelegatesHW
//
//  Created by Oleg Tverdokhleb on 02.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTPatient.h"

@interface OTDoctor : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger numberOfPatients;
@property (strong, nonatomic) NSMutableDictionary *patients;

- (void)report;
- (instancetype)initWithName:(NSString *)name;
- (void)patientFeelsBad:(OTPatient *)patient;

@end
