//
//  OTFriend.h
//  9_DelegatesHW
//
//  Created by Oleg Tverdokhleb on 02.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTPatient.h"

@interface OTFriend : NSObject <OTPatientDelegate>

@property (strong, nonatomic) NSString *name;

@end
