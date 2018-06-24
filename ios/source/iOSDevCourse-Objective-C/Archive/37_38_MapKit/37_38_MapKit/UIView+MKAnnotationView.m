//
//  MKAnnotationView.m
//  37_38_MapKit
//
//  Created by Oleg Tverdokhleb on 24.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "UIView+MKAnnotationView.h"
#import <MapKit/MKAnnotationView.h>

@implementation UIView (MKAnnotationView)

- (MKAnnotationView *) superAnnotationView {
    
    if ([self isKindOfClass:[MKAnnotationView class]]) {
        return (MKAnnotationView *) self;
    }
    
    if (!self.superview) {
        return nil;
    }
    
    return [self.superview superAnnotationView];
}

@end