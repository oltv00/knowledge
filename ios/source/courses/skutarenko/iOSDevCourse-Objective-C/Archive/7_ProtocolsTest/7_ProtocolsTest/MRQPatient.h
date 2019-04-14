//
//  MRQPatient.h
//  7_ProtocolsTest
//
//  Created by Oleg Tverdokhleb on 11.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MRQPatient <NSObject>

@required // or @optional - не обязательные.
@property (nonatomic, strong) NSString *name;
- (BOOL) areYouOK;
- (void) takePill;
- (void) makeShot;

@optional
- (NSString*) howIsYourFamily;
- (NSString*) howIsYourJob;
@end