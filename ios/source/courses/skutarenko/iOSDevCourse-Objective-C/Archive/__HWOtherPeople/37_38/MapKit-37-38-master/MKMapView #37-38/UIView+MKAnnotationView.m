//
//  UIView+MKAnnotationView.m
//  MKMapView #37-38
//
//  Created by Евгений Глухов on 27.08.15.
//  Copyright (c) 2015 EGApps. All rights reserved.
//

#import "UIView+MKAnnotationView.h"
#import <MapKit/MKAnnotationView.h>

@implementation UIView (MKAnnotationView)

- (MKAnnotationView*) superAnnotationView {
    
    if ([self isKindOfClass:[MKAnnotationView class]]) {
        
        return (MKAnnotationView*)self;
        
    }
    
    if (!self.superview) {
        
        return nil;
        
    }
    
    return [self.superview superAnnotationView];
    
}

@end
