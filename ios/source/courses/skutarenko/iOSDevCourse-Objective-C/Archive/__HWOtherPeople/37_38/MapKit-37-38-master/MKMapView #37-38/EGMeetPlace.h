//
//  EGMeetPlace.h
//  MKMapView #37-38
//
//  Created by Евгений Глухов on 30.08.15.
//  Copyright (c) 2015 EGApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "EGMapViewController.h"

@interface EGMeetPlace : NSObject <MKAnnotation>

// Класс для места встречи

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (instancetype)initWithMeetPlace:(CLLocationCoordinate2D) meetPlaceCoordinate;

@end
