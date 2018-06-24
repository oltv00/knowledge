//
//  MRQDoctor.h
//  9_DelegatesTest
//
//  Created by Oleg Tverdokhleb on 14.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRQPatient.h"

//@protocol MRQPationDelegate; - не написали так из-за непонятного warning.

@interface MRQDoctor : NSObject <MRQPationDelegate>

@end
