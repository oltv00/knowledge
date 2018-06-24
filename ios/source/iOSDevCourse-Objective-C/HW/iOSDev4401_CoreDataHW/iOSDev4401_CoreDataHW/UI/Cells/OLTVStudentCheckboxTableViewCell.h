//
//  OLTVStudentCheckboxTableViewCell.h
//  iOSDev4401_CoreDataHW
//
//  Created by Oleg Tverdokhleb on 24.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>

//TODO:Rename this to OLTVUserCheckboxTableViewCell
@interface OLTVStudentCheckboxTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *checkBoxImageView;
@property (weak, nonatomic) IBOutlet UILabel *studentFullNameLabel;
@end
