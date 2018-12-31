//
//  OLTVDetailedVideoTableViewCell.h
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 13/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OLTVDetailedVideoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIWebView *videoWebView;
@property (weak, nonatomic) IBOutlet UILabel *likesCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

+ (CGFloat)heightForText:(NSString *)text;

@end
