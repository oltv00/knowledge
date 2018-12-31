//
//  MKAnnotationView.h
//  37_38_MapKit
//
//  Created by Oleg Tverdokhleb on 24.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKAnnotationView;

@interface UIView (MKAnnotationView)

- (MKAnnotationView *) superAnnotationView;

@end