//
//  ASStudentsViewController.h
//  CoreDataTest
//
//  Created by Oleksii Skutarenko on 13.02.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import "ASCoreDataViewController.h"

@class ASCourse;

@interface ASStudentsViewController : ASCoreDataViewController

@property (strong, nonatomic) ASCourse* course;

@end
