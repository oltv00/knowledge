//
//  ASViewController.h
//  MapTest
//
//  Created by Oleksii Skutarenko on 11.01.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView;

@interface ASViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView* mapView;

@end
