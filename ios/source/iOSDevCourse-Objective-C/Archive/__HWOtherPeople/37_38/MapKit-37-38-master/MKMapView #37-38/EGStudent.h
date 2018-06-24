//
//  EGStudent.h
//  MKMapView #37-38
//
//  Created by Евгений Глухов on 26.08.15.
//  Copyright (c) 2015 EGApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "EGMapViewController.h"

@interface EGStudent : NSObject <MKAnnotation> // Реализовали тут протокол, чтобы объекты данного класса отображать на карте

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* surname;
@property (strong, nonatomic) NSString* gender;
@property (assign, nonatomic) NSDate* dateOfBirth;
@property (strong, nonatomic) NSString* address;
@property (assign, nonatomic) double distanceToMeeting;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (id)initWithStudentGeoInformationAndCenterPoint:(CLLocationCoordinate2D) centerPoint;

@end
