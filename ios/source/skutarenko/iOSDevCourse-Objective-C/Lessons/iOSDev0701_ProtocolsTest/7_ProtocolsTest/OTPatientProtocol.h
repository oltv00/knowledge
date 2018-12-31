//
//  OTPatientProtocol.h
//  7_ProtocolsTest
//
//  Created by Oleg Tverdokhleb on 31.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol OTPatientProtocol <NSObject>

@required
@property (strong, nonatomic) NSString *name;
- (BOOL)areYouOk;
- (void)takePill;
- (void)makeShot;

@optional
- (NSString *)howIsYourFamily;
- (NSString *)howIsYourJob;

@end