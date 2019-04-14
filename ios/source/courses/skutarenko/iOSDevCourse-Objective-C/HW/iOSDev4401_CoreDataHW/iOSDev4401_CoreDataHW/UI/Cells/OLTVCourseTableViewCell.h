//
//  OLTVCourseTableViewCell.h
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 23.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OLTVCourseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageCourse;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *branchLabel;
@property (weak, nonatomic) IBOutlet UILabel *teacherLabel;

@end
