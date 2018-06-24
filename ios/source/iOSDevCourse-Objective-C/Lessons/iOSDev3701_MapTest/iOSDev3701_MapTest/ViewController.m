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

@interface ViewController () <MKMapViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

- (IBAction)actionAdd:(UIBarButtonItem *)sender;
- (IBAction)actionSearch:(UIBarButtonItem *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  self.locationManager = [[CLLocationManager alloc] init];
  if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
    [self.locationManager requestWhenInUseAuthorization];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
  NSLog(@"didReceiveMemoryWarning");
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

#pragma mark - MKMapViewDelegate

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
  } else {
    pin.annotation = annotation;
  }
  return pin;
}



- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState {
  /*
   MKAnnotationViewDragStateNone = 0,      // View is at rest, sitting on the map.
   MKAnnotationViewDragStateStarting,      // View is beginning to drag (e.g. pin lift)
   MKAnnotationViewDragStateDragging,      // View is dragging ("lift" animations are complete)
   MKAnnotationViewDragStateCanceling,     // View was not dragged and should return to its starting position (e.g. pin drop)
   MKAnnotationViewDragStateEnding
   */
  
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
