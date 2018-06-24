//
//  OLTVStudentsTableViewController.h
//  iOSDev4101_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 22.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVCoreDataTableViewController.h"
@class OLTVCourse;

@interface OLTVStudentsTableViewController : OLTVCoreDataTableViewController

@property (strong, nonatomic) OLTVCourse *course;

@end
