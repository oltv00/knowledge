//
//  MapViewController.h
//  iOSDev373801_MapKit
//
//  Created by Oleg Tverdokhleb on 08/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKMapView;

@interface MapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
