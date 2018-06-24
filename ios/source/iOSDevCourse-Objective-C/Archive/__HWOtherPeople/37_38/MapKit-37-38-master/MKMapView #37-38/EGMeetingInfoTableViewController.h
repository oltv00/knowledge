//
//  EGMeetingInfoTableViewController.h
//  MKMapView #37-38
//
//  Created by Евгений Глухов on 01.09.15.
//  Copyright (c) 2015 EGApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGMeetingCell.h"
#import "EGStudent.h"

@interface EGMeetingInfoTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray* allFirstCircleStudentsSayingYES;
@property (strong, nonatomic) NSMutableArray* allFirstCircleStudents;

@property (strong, nonatomic) NSMutableArray* allSecondCircleStudentsSayingYES;
@property (strong, nonatomic) NSMutableArray* allSecondCircleStudents;

@property (strong, nonatomic) NSMutableArray* allThirdCircleStudentsSayingYES;
@property (strong, nonatomic) NSMutableArray* allThirdCircleStudents;

@end
