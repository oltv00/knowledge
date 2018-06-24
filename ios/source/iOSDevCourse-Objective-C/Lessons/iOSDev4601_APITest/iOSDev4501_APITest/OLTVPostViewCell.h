//
//  OLTVPostViewCell.h
//  iOSDev4501_APITest
//
//  Created by Oleg Tverdokhleb on 16/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OLTVPostViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *postLabel;

+ (CGFloat)heightForText:(NSString *)text;

@end