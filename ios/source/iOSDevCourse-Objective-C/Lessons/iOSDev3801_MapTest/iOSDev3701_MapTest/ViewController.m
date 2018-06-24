//
//  ViewController.m
//  iOSDev3701_MapTest
//
//  Created by Oleg Tverdokhleb on 05.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//
#import <MapKit/MapKit.h>

#import "ViewController.h"
#import "MapAnnotation.h"

#import "UIView+MKAnnotationView.h"

@interface ViewController () <MKMapViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) MKDirections *directions;

- (IBAction)actionAdd:(UIBarButtonItem *)sender;
- (IBAction)actionSearch:(UIBarButtonItem *)sender;

@end

@implementation ViewController

#pragma mark - Lifecycles
- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  self.locationManager = [[CLLocationManager alloc] init];
  [self.locationManager requestWhenInUseAuthorization];
  [self.locationManager requestAlwaysAuthorization];
  [self.locationManager startUpdatingLocation];
  
  self.geocoder = [CLGeocoder new];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
  NSLog(@"didReceiveMemoryWarning");
}

- (void)dealloc {
  if ([self.geocoder isGeocoding]) {
    [self.geocoder cancelGeocode];
  }
  if ([self.directions isCalculating]) {
    [self.directions cancel];
  }
}

#pragma mark - Additional

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                 message:message
                                                          preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                   style:UIAlertActionStyleDefault
                                                 handler:nil];
  [alert addAction:action];
  [self presentViewController:alert animated:YES completion:nil];
}

- (void)putPinToPoint:(CLLocationCoordinate2D)coordinate {
  MapAnnotation *annotation = [MapAnnotation new];
  annotation.title = @"From touch";
  annotation.coordinate = coordinate;
  [self.mapView addAnnotation:annotation];
}

#pragma mark - Action

- (IBAction)actionAdd:(UIBarButtonItem *)sender {
  MapAnnotation *annotation = [MapAnnotation new];
  annotation.title = @"Test Title";
  annotation.subtitle = @"Test Subtitle";
  annotation.coordinate = self.mapView.region.center;
  
  [self.mapView addAnnotation:annotation];
}

- (IBAction)actionSearch:(UIBarButtonItem *)sender {
  MKMapRect zoomRect = MKMapRectNull;
  
  for (id <MKAnnotation> annotation in self.mapView.annotations) {
    CLLocationCoordinate2D location = annotation.coordinate;
    MKMapPoint center = MKMapPointForCoordinate(location);
    static double delta = 20000;
    MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta * 2, delta * 2);
    zoomRect = MKMapRectUnion(zoomRect, rect);
  }
  
  zoomRect = [self.mapView mapRectThatFits:zoomRect];
  
  UIEdgeInsets insets = UIEdgeInsetsMake(20, 20, 20, 20);
  [self.mapView setVisibleMapRect:zoomRect edgePadding:insets animated:YES];
}

- (void)actionPinDescription:(UIButton *)sender {
  MKAnnotationView *annotationView = [sender superAnnotationView];
  if (!annotationView) {
    return;
  }
  CLLocationCoordinate2D coordinate = annotationView.annotation.coordinate;
  CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude
                                                    longitude:coordinate.longitude];
  if ([self.geocoder isGeocoding]) {
    [self.geocoder cancelGeocode];
  }
  [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks,
                                                                NSError * _Nullable error) {
    NSString *message = nil;
    if (error) {
      message = [error localizedDescription];
    } else {
      if ([placemarks count] > 0) {
        CLPlacemark *placemark = [placemarks firstObject];
        message = [placemark.addressDictionary description];
      } else {
        message = @"Placemarks not found";
      }
    }
    
    [self showAlertWithTitle:@"Location" message:message];
  }];
}

- (void)actionDirection:(UIButton *)sender {
  MKAnnotationView *annotationView = [sender superAnnotationView];
  if (!annotationView) {
    return;
  }
  MKDirectionsRequest *request = [MKDirectionsRequest new];
  request.source = [MKMapItem mapItemForCurrentLocation];
  
  CLLocationCoordinate2D coordinate = annotationView.annotation.coordinate;
  MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
  request.destination = [[MKMapItem alloc] initWithPlacemark:placemark];
  
  request.transportType = MKDirectionsTransportTypeAutomobile;
  request.requestsAlternateRoutes = YES;
  
  self.directions = [[MKDirections alloc] initWithRequest:request];
  [self.directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
    if (error) {
      [self showAlertWithTitle:@"Error" message:[error localizedDescription]];
    } else if ([response.routes count] == 0) {
      [self showAlertWithTitle:@"Error" message:@"No routes found"];
    } else {
      [self.mapView removeOverlays:[self.mapView overlays]];
      
      NSMutableArray *polylines = [NSMutableArray array];
      for (MKRoute *route in response.routes) {
        [polylines addObject:route.polyline];
      }
      
      [self.mapView addOverlays:polylines level:MKOverlayLevelAboveRoads];
    }
  }];
}

#pragma mark - MKMapViewDelegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
  if ([overlay isKindOfClass:[MKPolyline class]]) {
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    renderer.lineWidth = 2.f;
    renderer.strokeColor = [UIColor redColor];
    return renderer;
  }
  return nil;
}

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
  if ([annotation isKindOfClass:[MKUserLocation class]]) {
    return nil;
  }
  
  static NSString *identifier = @"Annotation";
  MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
  if (!pin) {
    pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    pin.pinTintColor = [MKPinAnnotationView purplePinColor];
    pin.animatesDrop = YES;
    pin.canShowCallout = YES;
    pin.draggable = YES;
    
    UIButton *description = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [description addTarget:self action:@selector(actionPinDescription:) forControlEvents:UIControlEventTouchUpInside];
    pin.rightCalloutAccessoryView = description;
    
    UIButton *direction = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [direction addTarget:self action:@selector(actionDirection:) forControlEvents:UIControlEventTouchUpInside];
    pin.leftCalloutAccessoryView = direction;
    
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
    NSLog(@"location = {%f, %f}", location.latitude, location.longitude);
    NSLog(@"point = %@", MKStringFromMapPoint(point));
  }
}

/*
 - (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animate {
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
 NSLog(@"mapViewDidFinishRenderingMap fullyRendered = %d", fullyRendered);
 }
 */

@end

/*
 - (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
 MKCoordinateRegion region;
 MKCoordinateSpan span;
 span.latitudeDelta = 0.005;
 span.longitudeDelta = 0.005;
 CLLocationCoordinate2D location;
 location.latitude = aUserLocation.coordinate.latitude;
 location.longitude = aUserLocation.coordinate.longitude;
 region.span = span;
 region.center = location;
 [aMapView setRegion:region animated:YES];
 }
 
 */
