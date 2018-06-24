//
//  OTDoctor.h
//  9_DelegatesTest
//
//  Created by Oleg Tverdokhleb on 02.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTPatient.h"

@interface OTDoctor : NSObject <OTPatientDelegate>

@end
