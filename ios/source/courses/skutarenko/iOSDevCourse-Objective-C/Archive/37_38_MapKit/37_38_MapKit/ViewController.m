//
//  ViewController.m
//  37_38_MapKit
//
//  Created by Oleg Tverdokhleb on 21.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "MRQMapAnnotation.h"
#import "UIView+MKAnnotationView.h"

@interface ViewController () <MKMapViewDelegate>

@property (strong, nonatomic) CLGeocoder *geoCoder;
@property (strong, nonatomic) MKDirections *direction;
@end

@implementation ViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setup];
}

- (void) dealloc {
  
  if ([self.geoCoder isGeocoding]) [self.geoCoder cancelGeocode];
  if ([self.direction isCalculating]) [self.direction cancel];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}
#pragma mark - Initial

- (void) setup {
  self.geoCoder = [[CLGeocoder alloc] init];
}

#pragma mark - Action

- (IBAction) actionAddBarButtonItemPressed:(UIBarButtonItem *) sender {
  
  MRQMapAnnotation *annotation = [[MRQMapAnnotation alloc] init];
  annotation.title = @"Title";
  annotation.subtitle = @"Subtitle";
  annotation.coordinate = self.mapView.region.center;
  
  [self.mapView addAnnotation:annotation];
}

- (IBAction) actionShowAllBarButtonItemPressed:(UIBarButtonItem *) sender {
  
  static double delta = 20000;
  MKMapRect zoomRect = MKMapRectNull;
  
  for (id <MKAnnotation> annotation in self.mapView.annotations) {
    
    MKMapPoint center = MKMapPointForCoordinate(annotation.coordinate);
    
    MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta * 2, delta * 2);
    zoomRect = MKMapRectUnion(zoomRect, rect);
  }
  
  zoomRect = [self.mapView mapRectThatFits:zoomRect];
  
  [self.mapView setVisibleMapRect:zoomRect
                      edgePadding:UIEdgeInsetsMake(100, 50, 50, 50)
                         animated:YES];
}

- (void) actionDescriptionButtonPressed:(UIButton *) sender {
  
  MKAnnotationView *annotationView = [sender superAnnotationView];
  
  if (!annotationView) {
    return;
  }
  
  CLLocationCoordinate2D coordinate = annotationView.annotation.coordinate;
  CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
  
  if ([self.geoCoder isGeocoding]) {
    [self.geoCoder cancelGeocode];
  }
  
  [self.geoCoder reverseGeocodeLocation:location
                      completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                        
                        NSString *message = nil;
                        
                        if (error) {
                          message = [error localizedDescription];
                        } else {
                          if ([placemarks count] > 0) {
                            CLPlacemark *placeMark = [placemarks firstObject];
                            message = [placeMark.addressDictionary description];
                          } else {
                            message = @"No Placemarks Found!";
                          }
                        }
                        
                        NSLog(@"%@", message);
                      }];
}

- (void) actionAddRouteButtonPressed:(UIButton *) sender {
  
  MKAnnotationView *annotationView = [sender superAnnotationView];
  
  if (!annotationView) return;
  if ([self.direction isCalculating]) [self.direction cancel];
  
  MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
  
  request.source = [MKMapItem mapItemForCurrentLocation];
  
  CLLocationCoordinate2D coordinate = annotationView.annotation.coordinate;
  
  MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
                                                 addressDictionary:nil];
  
  request.destination = [[MKMapItem alloc] initWithPlacemark:placemark];
  request.transportType = MKDirectionsTransportTypeAutomobile;
  
  MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
  [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
    
    if (error) {
      NSLog(@"%@", [error localizedDescription]);
    } else if ([response.routes count] == 0) {
      NSLog(@"Not found routes");
    } else {
      
      [self.mapView removeOverlays:[self.mapView overlays]];
      
      NSMutableArray *tempArray = [NSMutableArray array];
      for (MKRoute *route in response.routes) {
        [tempArray addObject:route.polyline];
      }
      [self.mapView addOverlays:tempArray level:MKOverlayLevelAboveRoads];
    }
  }];
}

#pragma mark - MKMapViewDelegate

/*
 - (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
 NSLog(@"regionWillChangeAnimated");
 }
 
 - (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
 NSLog(@"regionDidChangeAnimated");
 }
 
 - (void)mapViewWillStartLoadingMap:(MKMapView *)mapView {
 NSLog(@"mapViewWillStartLoadingMap");
 }
 
 - (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
 NSLog(@"mapViewDidFinishLoadingMap");
 }
 
 - (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error {
 NSLog(@"mapViewDidFailLoadingMap");
 }
 
 - (void)mapViewWillStartRenderingMap:(MKMapView *)mapView {
 NSLog(@"mapViewWillStartRenderingMap");
 }
 
 - (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
 NSLog(@"mapViewDidFinishRenderingMap");
 }
 */

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
  
  if ([annotation isKindOfClass:[MKUserLocation class]]) {
    return nil;
  }
  
  static NSString *identifier = @"identifier";
  
  MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
  
  if (!pin) {
    pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    pin.pinTintColor = [MKPinAnnotationView purplePinColor];
    pin.canShowCallout  = YES;
    pin.draggable       = YES;
    pin.animatesDrop    = YES;
    
    UIButton *descriptionButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    [descriptionButton addTarget:self
                          action:@selector(actionDescriptionButtonPressed:)
                forControlEvents:UIControlEventTouchUpInside];
    
    pin.rightCalloutAccessoryView = descriptionButton;
    
    UIButton *addRouteButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    [addRouteButton addTarget:self
                       action:@selector(actionAddBarButtonItemPressed:)
             forControlEvents:UIControlEventTouchUpInside];
    
  } else {
    
    pin.annotation = annotation;
  }
  
  return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState {
  
  if (newState == MKAnnotationViewDragStateEnding) {
    
    CLLocationCoordinate2D location = view.annotation.coordinate;
    MKMapPoint point = MKMapPointForCoordinate(location);
    NSLog(@"\nlocation: {%f, %f}\npoint = %@", location.latitude, location.longitude, MKStringFromMapPoint(point));
  }
}

@end
