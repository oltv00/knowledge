//
//  DetailedStudentTableViewController.m
//  iOSDev373801_MapKit
//
//  Created by Oleg Tverdokhleb on 09/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <CoreLocation/CLGeocoder.h>
#import <MapKit/MKAnnotation.h>

#import "MapAnnotation.h"

#import "DetailedStudentTableViewController.h"

@interface DetailedStudentTableViewController ()

@property (strong, nonatomic) CLGeocoder *geocoder;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

- (IBAction)actionDone:(UIBarButtonItem *)sender;

@end

@implementation DetailedStudentTableViewController

#pragma mark - Lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initializeProperties];
  [self contentSetup];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)dealloc {
  [self geocoderCheck];
}

- (void)initializeProperties {
  self.geocoder = [CLGeocoder new];
}

- (void)contentSetup {
  [self geocoderCheck];
  
  MapAnnotation *annotation = nil;
  if ([self.object isKindOfClass:[MapAnnotation class]]) {
      annotation = self.object;
  }
  
  __weak DetailedStudentTableViewController *weakSelf = self;
  
  double latitude = annotation.coordinate.latitude;
  double longitude = annotation.coordinate.longitude;
  CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
  [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
    if (error) {
      [self showAlertWithTitle:@"Error" message:[error localizedDescription]];
    } else {
      if ([placemarks count] == 0) {
        [self showAlertWithTitle:@"Error" message:@"Placemarks not found"];
      } else {
        
        CLPlacemark *placemark = [placemarks firstObject];
        NSArray *formattedAddressLines = placemark.addressDictionary[@"FormattedAddressLines"];
        NSMutableString *resultString = [NSMutableString new];
        for (NSString *string in formattedAddressLines) {
          [resultString appendString:string];
          [resultString appendString:@" "];
        }
        
        weakSelf.fullNameLabel.text = annotation.title;
        weakSelf.birthdayLabel.text = annotation.subtitle;
        weakSelf.imageView.image = annotation.image;
        weakSelf.addressLabel.text = resultString;
      }
    }
  }];
}

#pragma mark - Action

- (IBAction)actionDone:(UIBarButtonItem *)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Additional

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
  UIAlertController *ac = [UIAlertController alertControllerWithTitle:title
                                                              message:message
                                                       preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
  [ac addAction:action];
  [self presentViewController:ac animated:YES completion:nil];
}

- (void)geocoderCheck {
  if ([self.geocoder isGeocoding]) {
    [self.geocoder cancelGeocode];
  }
}

@end
