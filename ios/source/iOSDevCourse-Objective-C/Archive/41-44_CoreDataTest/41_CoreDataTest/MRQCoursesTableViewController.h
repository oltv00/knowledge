//
//  MRQCoursesTableViewController.h
//  41_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 10.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQCoreDataTableViewController.h"

@class MRQUniversity;

@interface MRQCoursesTableViewController : MRQCoreDataTableViewController

@property (strong, nonatomic) MRQUniversity *university;

@end
