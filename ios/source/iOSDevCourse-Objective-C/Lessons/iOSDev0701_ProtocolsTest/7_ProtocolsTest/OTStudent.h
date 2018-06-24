//
//  OTStudent.h
//  7_ProtocolsTest
//
//  Created by Oleg Tverdokhleb on 31.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTPatientProtocol.h"

@interface OTStudent : NSObject <OTPatientProtocol>
@property (strong, nonatomic) NSString *universityName;
@property (strong, nonatomic) NSString *name;

- (void)study;

@end
