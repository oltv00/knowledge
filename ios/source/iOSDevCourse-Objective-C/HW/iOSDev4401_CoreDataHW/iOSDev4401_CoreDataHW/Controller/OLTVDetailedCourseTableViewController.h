//
//  OLTVDetailedCourseTableViewController.h
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 22.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OLTVCourse;

//TODO:Change UITableViewController to UIViewController and add UIBarButtonItem 'Save' instead 'OK'
@interface OLTVDetailedCourseTableViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) OLTVCourse *course;
@property (strong, nonatomic) NSMutableArray *students;
@property (strong, nonatomic) OLTVTeacher *courseTeacher;
@end
