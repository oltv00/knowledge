//
//  MapViewController.m
//  iOSDev373801_MapKit
//
//  Created by Oleg Tverdokhleb on 08/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

//Kit
#import <MapKit/MapKit.h>

//Model
#import "Student.h"
#import "MapAnnotation.h"

//Controllers
#import "MapViewController.h"
#import "DetailedStudentTableViewController.h"

//Categories
#import "UIView+AnnotationView.h"

static NSInteger const kMapDelta = 200000.f;
static NSInteger const kMapFirstCircleRadius = 7500.f;
static NSInteger const kMapSecondCircleRadius = kMapFirstCircleRadius * 2;
static NSInteger const kMapThirdCircleRadius = kMapFirstCircleRadius * 3;
static NSString *const kMeetingAnnotationIdentifier = @"kMeetingAnnotationIdentifier";
static NSString *const kStudentAnnotationIdentifier = @"kStudentAnnotationIdentifier";

@interface MapViewController ()

//Map properties
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *meetingLocation;
@property (assign, nonatomic) MKMapPoint mapCenter;
@property (strong, nonatomic) MKDirections *direction;

//Private data
@property (strong, nonatomic) NSArray *students;
@property (strong, nonatomic) NSArray *firstCircleRadius;
@property (strong, nonatomic) NSArray *secondCircleRadius;
@property (strong, nonatomic) NSArray *thirdCircleRadius;
@property (strong, nonatomic) NSMutableArray *polylines;
@property (assign, nonatomic) BOOL firstStart;

//IBOs
@property (weak, nonatomic) IBOutlet UIView *resultView;

//Result View Labels
@property (weak, nonatomic) IBOutlet UILabel *firstResultViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondResultViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdResultViewLabel;

//Actions
- (IBAction)actionCenterRefresh:(UIBarButtonItem *)sender;
- (IBAction)actionAddStudents:(UIBarButtonItem *)sender;
- (IBAction)actionAddMeeting:(UIBarButtonItem *)sender;
- (IBAction)actionAddRouteToMeeting:(UIBarButtonItem *)sender;

@end

@implementation MapViewController

#pragma mark - Lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  [self transparentNavigationBar];
  [self initializeProperties];
  [self callUserLocation];
}

- (void)dealloc {
  if ([self.direction isCalculating]) {
    [self.direction cancel];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)initializeProperties {
  self.resultView.hidden = YES;
  self.resultView.alpha = 0.0f;
  self.firstStart = YES;
}

#pragma mark - Additional

- (void)callUserLocation {
  self.locationManager = [CLLocationManager new];
  [self.locationManager requestWhenInUseAuthorization];
}

- (void)transparentNavigationBar {
  [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
  [self.navigationController.navigationBar setShadowImage:[UIImage new]];
  [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
  [self.navigationController.navigationBar setTranslucent:YES];
}

- (void)addStudentsWithCenter:(MKMapPoint)center maxDelta:(double)maxDelta {
  self.students = [Student initStudentsWithCount:20 inCenter:center maxDelta:maxDelta];
  for (Student *student in self.students) {
    MapAnnotation *annotation = [MapAnnotation new];
    annotation.title = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
    annotation.subtitle = [student stringFromDate:student.birthday];
    annotation.image = student.gender ? [UIImage imageNamed:@"male"] : [UIImage imageNamed:@"female"];
    annotation.identifier = kStudentAnnotationIdentifier;
    
    MKMapPoint studentPoint = MKMapPointMake(student.x, student.y);
    annotation.coordinate = MKCoordinateForMapPoint(studentPoint);
    [self.mapView addAnnotation:annotation];
  }
}

- (void)addCircleOverlayWithCoordinate:(CLLocationCoordinate2D)coordinate {
  MKCircle *circle1 = [MKCircle circleWithCenterCoordinate:coordinate radius:kMapFirstCircleRadius];
  MKCircle *circle2 = [MKCircle circleWithCenterCoordinate:coordinate radius:kMapSecondCircleRadius];
  MKCircle *circle3 = [MKCircle circleWithCenterCoordinate:coordinate radius:kMapThirdCircleRadius];
  
  NSArray *circles = @[circle1, circle2, circle3];
  [self.mapView addOverlays:circles];
}

- (void)addRouteToMeeting:(CLLocation *)meetingLocation fromAnnotations:(id <MKAnnotation>)annotation {
  
  if ([annotation isKindOfClass:[MapAnnotation class]]) {
    MapAnnotation *mapAnnotation = annotation;
    if ([mapAnnotation.identifier isEqualToString:kStudentAnnotationIdentifier]) {
      
      MKDirectionsRequest *directionRequest = [MKDirectionsRequest new];
      directionRequest.requestsAlternateRoutes = NO;
      directionRequest.transportType = MKDirectionsTransportTypeAny;
      
      MKPlacemark *sourcePlacemark = [[MKPlacemark alloc] initWithCoordinate:mapAnnotation.coordinate addressDictionary:nil];
      MKPlacemark *destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:meetingLocation.coordinate addressDictionary:nil];
      
      MKMapItem *sourceMapItem = [[MKMapItem alloc] initWithPlacemark:sourcePlacemark];
      MKMapItem *destinationMapItem = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];
      
      directionRequest.source = sourceMapItem;
      directionRequest.destination = destinationMapItem;
      
      self.direction = [[MKDirections alloc] initWithRequest:directionRequest];
      [self.direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
          NSLog(@"%@", [error localizedDescription]);
          //[self showAlertWithTitle:@"Error" message:[error localizedDescription]];
        } else if ([response.routes count] == 0) {
          [self showAlertWithTitle:@"Error" message:@"No routes"];
        } else {
          
          NSMutableArray *polylines = [NSMutableArray array];
          for (MKRoute *route in response.routes) {
            [polylines addObject:route.polyline];
            [self.polylines addObject:route.polyline];
          }
          [self.mapView addOverlays:polylines level:MKOverlayLevelAboveRoads];
        }
      }];
    }
  }
}

- (void)countOfStudentsWithMeetingCoordinate:(CLLocation *)meetingCoordinate {
  NSInteger firstCircle = 0;
  NSInteger secondCircle = 0;
  NSInteger thirdCircle = 0;
  
  NSMutableArray *firstCircleArray = [NSMutableArray array];
  NSMutableArray *secondCircleArray = [NSMutableArray array];
  NSMutableArray *thirdCircleArray = [NSMutableArray array];
  
  for (id <MKAnnotation> annotation in [self.mapView annotations]) {
    if ([annotation isKindOfClass:[MapAnnotation class]]) {
      MapAnnotation *mapAnnotation = annotation;
      if ([mapAnnotation.identifier isEqualToString:kStudentAnnotationIdentifier]) {
        CLLocationDegrees latitude = mapAnnotation.coordinate.latitude;
        CLLocationDegrees longitude = mapAnnotation.coordinate.longitude;
        CLLocation *studentLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        CLLocationDistance distance = [meetingCoordinate distanceFromLocation:studentLocation];
        
        if (distance > kMapThirdCircleRadius) {
          continue;
        } else if (distance > kMapSecondCircleRadius) {
          
          thirdCircle += 1;
          [thirdCircleArray addObject:annotation];
          
        } else if (distance > kMapFirstCircleRadius) {
          
          secondCircle += 1;
          [secondCircleArray addObject:annotation];
          
        } else {
          
          firstCircle += 1;
          [firstCircleArray addObject:annotation];
          
        }
      }
    }
  }
  
  self.firstResultViewLabel.text = [NSString stringWithFormat:@"%ld", firstCircle];
  self.secondResultViewLabel.text = [NSString stringWithFormat:@"%ld", secondCircle];
  self.thirdResultViewLabel.text = [NSString stringWithFormat:@"%ld", thirdCircle];
  
  self.firstCircleRadius = [NSArray arrayWithArray:firstCircleArray];
  self.secondCircleRadius = [NSArray arrayWithArray:secondCircleArray];
  self.thirdCircleRadius = [NSArray arrayWithArray:thirdCircleArray];
}

- (UIImage *)resizeImage:(UIImage *)inputImage toSize:(CGSize)size {
  UIGraphicsBeginImageContext(size);
  [inputImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
  UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return resizedImage;
}

- (void)refreshMapCenter {
  CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(55.753558, 37.620011);
  MKMapPoint center = MKMapPointForCoordinate(coordinate);
  double delta = kMapDelta;
  MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta*2, delta*2);
  UIEdgeInsets insets = UIEdgeInsetsMake(20, 20, 20, 20);
  
  self.mapCenter = center;
  [self.mapView setVisibleMapRect:rect edgePadding:insets animated:YES];
}

- (void)updateMeetingLocation:(id <MKAnnotation>)meeting {
  CLLocationDegrees meetingLatitude = meeting.coordinate.latitude;
  CLLocationDegrees meetingLongitude = meeting.coordinate.longitude;
  self.meetingLocation = [[CLLocation alloc] initWithLatitude:meetingLatitude longitude:meetingLongitude];
}

- (void)showResultView:(BOOL)show {
  if (show) {
    [UIView animateWithDuration:0.3f animations:^{
      self.resultView.hidden = NO;
      self.resultView.alpha = 0.6f;
      
    } completion:^(BOOL finished) {
      [self countOfStudentsWithMeetingCoordinate:self.meetingLocation];
    }];
  } else {
    [UIView animateWithDuration:0.3f animations:^{
      self.resultView.alpha = 0.0f;
      
    } completion:^(BOOL finished) {
      self.resultView.hidden = YES;
    }];
  }
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
  UIAlertController *ac = [UIAlertController alertControllerWithTitle:title
                                                              message:message
                                                       preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
  [ac addAction:action];
  [self presentViewController:ac animated:YES completion:nil];
}

#pragma mark - Action

- (IBAction)actionCenterRefresh:(UIBarButtonItem *)sender {
  [self refreshMapCenter];
  [self.mapView removeAnnotations:[self.mapView annotations]];
  [self.mapView removeOverlays:[self.mapView overlays]];
}

- (IBAction)actionAddStudents:(UIBarButtonItem *)sender {
  [self addStudentsWithCenter:self.mapCenter maxDelta:kMapDelta];
}

- (IBAction)actionAddMeeting:(UIBarButtonItem *)sender {
  
  __weak MapViewController *weakSelf = self;
  
  UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Meeting"
                                                              message:@"Please enter meeting name"
                                                       preferredStyle:UIAlertControllerStyleAlert];
  [ac addTextFieldWithConfigurationHandler:nil];
  
  UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    MapAnnotation *meeting = [[MapAnnotation alloc] init];
    meeting.title = [ac.textFields[0] text];
    meeting.coordinate = weakSelf.mapView.region.center;
    meeting.identifier = kMeetingAnnotationIdentifier;
    meeting.image = [UIImage imageNamed:@"meeting"];
    
    [weakSelf.mapView addAnnotation:meeting];
    [weakSelf addCircleOverlayWithCoordinate:meeting.coordinate];
    [weakSelf updateMeetingLocation:meeting];
    [weakSelf countOfStudentsWithMeetingCoordinate:weakSelf.meetingLocation];
  }];
  
  UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
  [ac addAction:ok];
  [ac addAction:cancel];
  
  [self presentViewController:ac animated:YES completion:nil];
}

- (IBAction)actionAddRouteToMeeting:(UIBarButtonItem *)sender {
  if ([self.direction isCalculating]) {
    [self.direction cancel];
  }
  
  [self.mapView removeOverlays:self.polylines];
  self.polylines = [NSMutableArray array];
  
  for (MapAnnotation *annotation in self.firstCircleRadius) {
    NSInteger studentWill = arc4random_uniform(101);
    if (studentWill > 10) {
      [self addRouteToMeeting:self.meetingLocation fromAnnotations:annotation];
    }
  }
  
  for (MapAnnotation *annotation in self.secondCircleRadius) {
    NSInteger studentWill = arc4random_uniform(101);
    if (studentWill > 50) {
      [self addRouteToMeeting:self.meetingLocation fromAnnotations:annotation];
    }
  }
  
  for (MapAnnotation *annotation in self.thirdCircleRadius) {
    NSInteger studentWill = arc4random_uniform(101);
    if (studentWill > 80) {
      [self addRouteToMeeting:self.meetingLocation fromAnnotations:annotation];
    }
  }
}

- (void)actionAnnotationInfo:(UIButton *)sender {
  MKAnnotationView *annotationView = [sender superAnnotationView];
  MapAnnotation *annotation = annotationView.annotation;
  
  DetailedStudentTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailedStudentTableViewController"];
  vc.object = annotation;
  
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    [self presentViewController:vc animated:YES completion:nil];
  } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    vc.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *pc = [vc popoverPresentationController];
    pc.permittedArrowDirections = UIPopoverArrowDirectionAny;
    pc.sourceView = sender;
    pc.sourceRect = CGRectMake(CGRectGetMidX(sender.frame), CGRectGetMidY(sender.frame), 0, 0);
    [self presentViewController:vc animated:YES completion:nil];
  }
}

#pragma mark - MKMapView

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
  if ([overlay isKindOfClass:[MKCircle class]]) {
    MKCircleRenderer *circle = [[MKCircleRenderer alloc] initWithCircle:overlay];
    circle.lineWidth = 1.f;
    circle.fillColor = [UIColor blueColor];
    circle.alpha = 0.075f;
    return circle;
    
  } else if ([overlay isKindOfClass:[MKPolyline class]]) {
    MKPolylineRenderer *polyline = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    polyline.lineWidth = 3.f;
    polyline.strokeColor = [UIColor redColor];
    return polyline;
  }
  
  return nil;
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
  if ([view.annotation isKindOfClass:[MapAnnotation class]]) {
    MapAnnotation *mapAnnotation = view.annotation;
    
    if ([mapAnnotation.identifier isEqualToString:kMeetingAnnotationIdentifier]) {
      [self showResultView:YES];
    }
  }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
  if ([view.annotation isKindOfClass:[MapAnnotation class]]) {
    MapAnnotation *mapAnnotation = view.annotation;
    
    if ([mapAnnotation.identifier isEqualToString:kMeetingAnnotationIdentifier]) {
      [self showResultView:NO];
    }
  }
}

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
  if ([annotation isKindOfClass:[MKUserLocation class]]) {
    return nil;
  }
  
  MapAnnotation *currentAnnotation = annotation;
  
  static NSString *studentAnnotationView = @"studentAnnotationView";
  static NSString *meetingAnnotationView = @"meetingAnnotationView";
  
  if ([currentAnnotation.identifier isEqualToString:kMeetingAnnotationIdentifier]) {
    
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:meetingAnnotationView];
    if (!annotationView) {
      annotationView = [[MKAnnotationView alloc] initWithAnnotation:currentAnnotation reuseIdentifier:meetingAnnotationView];
      annotationView.image = [self resizeImage:currentAnnotation.image toSize:CGSizeMake(50, 50)];
      annotationView.canShowCallout = YES;
      annotationView.draggable = YES;
      return annotationView;
    } else {
      annotationView.annotation = annotation;
    }
    
  } else if ([currentAnnotation.identifier isEqualToString:kStudentAnnotationIdentifier]) {
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:studentAnnotationView];
    
    if (!annotationView) {
      annotationView = [[MKAnnotationView alloc] initWithAnnotation:currentAnnotation reuseIdentifier:studentAnnotationView];
      annotationView.image = [self resizeImage:currentAnnotation.image toSize:CGSizeMake(25, 25)];
      annotationView.canShowCallout = YES;
      
      UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
      [infoButton addTarget:self action:@selector(actionAnnotationInfo:) forControlEvents:UIControlEventTouchUpInside];
      annotationView.rightCalloutAccessoryView = infoButton;
    } else {
      annotationView.annotation = annotation;
    }
    return annotationView;
  }
  return nil;
}

- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
  if (fullyRendered) {
    CLLocationCoordinate2D centerCoordinate = mapView.centerCoordinate;
    self.mapCenter = MKMapPointForCoordinate(centerCoordinate);
  }
  
  if (self.firstStart && fullyRendered) {
    self.firstStart = NO;
    [self refreshMapCenter];
  }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
  
  if ([view.annotation isKindOfClass:[MapAnnotation class]]) {
    MapAnnotation *mapAnnotation = view.annotation;
    if ([mapAnnotation.identifier isEqualToString:kMeetingAnnotationIdentifier]) {
      if (newState == MKAnnotationViewDragStateEnding) {
        view.dragState = MKAnnotationViewDragStateNone;
        
        [self addCircleOverlayWithCoordinate:view.annotation.coordinate];
        [self updateMeetingLocation:view.annotation];
        [self countOfStudentsWithMeetingCoordinate:self.meetingLocation];
        
      } else if (newState == MKAnnotationViewDragStateStarting) {
        [self.mapView removeOverlays:[mapView overlays]];
      }
    }
  }
}

@end
