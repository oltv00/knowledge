//
//  OTPatient.h
//  9_DelegatesTest
//
//  Created by Oleg Tverdokhleb on 02.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol OTPatientDelegate;

@interface OTPatient : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) CGFloat temperature;
@property (weak, nonatomic) id <OTPatientDelegate> delegate;

- (BOOL)howAreYou;
- (void)takePill;
- (void)makeShot;

@end

@protocol OTPatientDelegate <NSObject>
@required
- (void)patientFeelsBad:(OTPatient *)patient;
- (void)patient:(OTPatient *)patient hasQuestion:(NSString *)question;

@end