//
//  DetailedStudentTableViewController.h
//  iOSDev373801_MapKit
//
//  Created by Oleg Tverdokhleb on 09/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLGeocoder;
@protocol MKAnnotation;

@interface DetailedStudentTableViewController : UITableViewController
@property (strong, nonatomic) id <MKAnnotation> object;
@end
