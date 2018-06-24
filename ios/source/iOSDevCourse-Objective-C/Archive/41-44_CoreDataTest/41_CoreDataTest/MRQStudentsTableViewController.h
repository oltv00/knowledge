//
//  MRQStudentsTableViewController.h
//  41_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 10.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQCoreDataTableViewController.h"

@class MRQCourse;

@interface MRQStudentsTableViewController : MRQCoreDataTableViewController

@property (strong, nonatomic) MRQCourse *course;

@end
