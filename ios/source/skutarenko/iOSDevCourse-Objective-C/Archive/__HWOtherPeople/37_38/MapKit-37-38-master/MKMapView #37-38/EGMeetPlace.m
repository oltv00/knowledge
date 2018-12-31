//
//  EGMeetPlace.m
//  MKMapView #37-38
//
//  Created by Евгений Глухов on 30.08.15.
//  Copyright (c) 2015 EGApps. All rights reserved.
//

#import "EGMeetPlace.h"

@implementation EGMeetPlace

- (instancetype)initWithMeetPlace:(CLLocationCoordinate2D) meetPlaceCoordinate
{ // создали отдельный класс, с которым будем инициализировать метку встречи по отправленной координате meetPlaceCoordinate
    self = [super init];
    
    if (self) {
        
        self.coordinate = meetPlaceCoordinate;
        
        self.title = @"MEETING PLACE";
        
        self.subtitle = [NSString stringWithFormat:@"latitude - %.2f longitude - %.2f", self.coordinate.latitude, self.coordinate.longitude];
        
    }
    
    return self;
}

@end
