//
//  OLTVDetailedUserTableViewController.h
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 22.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OLTVDetailedUser){
  OLTVDetailedUserStudent = 01,
  OLTVDetailedUserTeacher = 02
};

@class OLTVUser;

@interface OLTVDetailedUserTableViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) OLTVUser *user;
@property (strong, nonatomic) OLTVCourse *course;
@property (assign, nonatomic) OLTVDetailedUser detailedUser;
@end
