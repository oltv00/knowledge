//
//  ViewController.h
//  37_38_MapKit
//
//  Created by Oleg Tverdokhleb on 21.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction) actionAddBarButtonItemPressed:(UIBarButtonItem *) sender;
- (IBAction) actionShowAllBarButtonItemPressed:(UIBarButtonItem *) sender;

@end



