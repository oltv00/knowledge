//
//  MRQPatient.h
//  9_DelegatesTest
//
//  Created by Oleg Tverdokhleb on 14.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MRQPationDelegate;

@interface MRQPatient : NSObject

@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) CGFloat temperature;
@property (weak, nonatomic) id <MRQPationDelegate> delegate;

- (BOOL) howAreYou;
- (void) takePill;
- (void) makeShot;

@end

@protocol MRQPationDelegate

@required
- (void) patientFeelsBad:(MRQPatient*) patient;
- (void) patient:(MRQPatient*) patient hasQuestion:(NSString*) question;

@end