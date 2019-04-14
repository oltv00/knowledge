//
//  MRQDeveloper.h
//  7_ProtocolsTest
//
//  Created by Oleg Tverdokhleb on 11.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MRQPatient.h"

@interface MRQDeveloper : NSObject <MRQPatient>

@property (nonatomic, assign) CGFloat experience;
@property (nonatomic, strong) NSString *name;

- (void) work;

@end
