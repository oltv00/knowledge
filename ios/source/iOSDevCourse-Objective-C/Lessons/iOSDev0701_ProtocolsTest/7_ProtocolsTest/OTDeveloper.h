//
//  OTBoxer.h
//  7_ProtocolsTest
//
//  Created by Oleg Tverdokhleb on 31.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OTPatientProtocol.h"

@interface OTDeveloper : NSObject <OTPatientProtocol>

@property (assign, nonatomic) CGFloat experience;
@property (strong, nonatomic) NSString *name;

- (void)work;

@end
