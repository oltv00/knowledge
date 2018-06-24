//
//  EGMeetingCell.h
//  MKMapView #37-38
//
//  Created by Евгений Глухов on 02.09.15.
//  Copyright (c) 2015 EGApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGMeetingInfoTableViewController.h"


@interface EGMeetingCell : UITableViewCell

// Класс для нашей кастомной ячейки

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nameSurnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *yesOrNoView;



@end
