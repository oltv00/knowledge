//
//  OLTVVIdeoTableViewCell.h
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 11/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OLTVVideoAlbumTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end
