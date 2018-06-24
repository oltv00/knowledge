//
//  MRQDoctor.h
//  9_DelegatesTestRestoProg
//
//  Created by Oleg Tverdokhleb on 20.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRQPatient.h"

@protocol MRQPatientDelegate;

@interface MRQDoctor : NSObject <MRQPatientDelegate>



@end
