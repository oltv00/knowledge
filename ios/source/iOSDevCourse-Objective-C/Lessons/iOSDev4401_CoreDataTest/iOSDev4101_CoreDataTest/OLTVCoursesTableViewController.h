//
//  OLTVCoursesTableViewController.h
//  iOSDev4101_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 22.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVCoreDataTableViewController.h"
@class OLTVUniversity;

@interface OLTVCoursesTableViewController : OLTVCoreDataTableViewController

@property (strong, nonatomic) OLTVUniversity *university;

@end
