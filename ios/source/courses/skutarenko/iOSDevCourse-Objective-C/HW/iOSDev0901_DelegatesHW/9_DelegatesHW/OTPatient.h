//
//  OTPatient.h
//  9_DelegatesHW
//
//  Created by Oleg Tverdokhleb on 02.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OTPatientBodyPart) {
    OTPatientBodyPartHead,
    OTPatientBodyPartHand,
    OTPatientBodyPartBelly,
    OTPatientBodyPartLeg
};

@protocol OTPatientDelegate;

@interface OTPatient : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *patientID;
@property (strong, nonatomic) NSString *bodyPart;

@property (assign, nonatomic) CGFloat temperature;
@property (assign, nonatomic) NSInteger doctorRating;

@property (assign, nonatomic) OTPatientBodyPart indexOfBodyPart;
@property (assign, nonatomic, getter=isPatient) BOOL isPatient;
@property (weak, nonatomic) id <OTPatientDelegate> delegate;

- (instancetype)initWithPatientID:(NSString *)patientID;

- (void)feelsBad;
- (void)takePill;
- (void)makeShot;
- (void)shouldRest;
- (void)cureFromBodyPart;

@end

@protocol OTPatientDelegate <NSObject>

@required
@property (strong, nonatomic) NSString *name;
- (void)patientFeelsBad:(OTPatient *)patient;

@end