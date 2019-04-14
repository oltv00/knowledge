//
//  OLTVDetailedCourseTableViewCell.h
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 23.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OLTVDetailedCourseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *subjectField;
@property (weak, nonatomic) IBOutlet UITextField *branchField;
@property (weak, nonatomic) IBOutlet UITextField *teacherField;

@end
