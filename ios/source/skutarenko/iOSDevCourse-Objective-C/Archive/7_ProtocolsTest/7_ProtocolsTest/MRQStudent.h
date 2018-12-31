//
//  MRQStudent.h
//  7_ProtocolsTest
//
//  Created by Oleg Tverdokhleb on 11.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRQPatient.h"

@interface MRQStudent : NSObject <MRQPatient>

@property (nonatomic, strong) NSString *universityName;
@property (nonatomic, strong) NSString *name;

- (void) study;

@end
