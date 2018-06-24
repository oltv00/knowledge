//
//  UIView+MKAnnotationView.h
//  MKMapView #37-38
//
//  Created by Евгений Глухов on 27.08.15.
//  Copyright (c) 2015 EGApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKAnnotationView;

@interface UIView (MKAnnotationView)

// Категория, где мы делаем рекурсию, для того чтобы определять, по какой именно кнопке информации какого студента мы нажимаем.

- (MKAnnotationView*) superAnnotationView;

@end
