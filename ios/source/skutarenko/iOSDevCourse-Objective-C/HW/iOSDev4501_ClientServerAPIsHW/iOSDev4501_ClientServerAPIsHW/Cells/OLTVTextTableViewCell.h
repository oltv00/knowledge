//
//  OLTVTextTableViewCell.h
//  iOSDev4501_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 09/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OLTVTextTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *wallTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *userFullNameLabel;

- (CGFloat)heightForText:(NSString*)text;

@end
