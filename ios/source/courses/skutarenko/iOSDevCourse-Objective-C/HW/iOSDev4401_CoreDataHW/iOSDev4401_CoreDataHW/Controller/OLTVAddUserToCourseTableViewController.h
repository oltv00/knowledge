//
//  OLTVCheckboxStudentsTableViewController.h
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 24.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OLTVInputUserToVC) {
  OLTVInputUserToVCStudent,
  OLTVInputUserToVCTeacher
};

@class OLTVCourse;
@class OLTVDetailedCourseTableViewController;

@interface OLTVAddUserToCourseTableViewController : UIViewController

@property (strong, nonatomic) OLTVCourse *course;
@property (strong, nonatomic) NSArray *allObjects;
@property (assign, nonatomic) OLTVInputUserToVC inputUser;

@property (strong, nonatomic) OLTVDetailedCourseTableViewController *inputVC;
@property (strong, nonatomic) UITextField *inputField;

@end
