//
//  MRQPatient.h
//  9_DelegatesTestRestoProg
//
//  Created by Oleg Tverdokhleb on 20.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MRQPatientDelegate;

@interface MRQPatient : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) CGFloat temperature;
@property (assign, nonatomic) BOOL headache; // Головная боль
@property (assign, nonatomic) BOOL chestPain; //Грудная боль

@property (weak, nonatomic) id <MRQPatientDelegate> delegate;

- (void) conditionWorsened;
- (BOOL) howAreYou;
- (void) theRest;
- (void) takePill;
- (void) makeShot;
- (void) makeTheSurgery;

@end

@protocol MRQPatientDelegate

- (void) patientFeelsBad:(MRQPatient*) patient;
- (void) patient:(MRQPatient*) patient hasQuestion:(NSString*) question;

@end