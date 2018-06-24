//
//  OLTVPostViewCell.m
//  iOSDev4501_APITest
//
//  Created by Oleg Tverdokhleb on 16/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVPostViewCell.h"

@implementation OLTVPostViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

+ (CGFloat)heightForText:(NSString *)text {
  CGFloat offset = 8.f;
  UIFont *font = [UIFont systemFontOfSize:17.f];
  
  NSShadow *shadow = [[NSShadow alloc] init];
  shadow.shadowOffset = CGSizeMake(0.f, -1.f);
  
  NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
  [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
  [paragraph setAlignment:NSTextAlignmentCenter];
  
  NSDictionary *params = @{
                           NSFontAttributeName : font,
                           NSParagraphStyleAttributeName : paragraph,
                           NSShadowAttributeName : shadow
                           };
  
  CGRect rect = [text boundingRectWithSize:CGSizeMake(320 - 2 * offset, CGFLOAT_MAX)
                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                attributes:params
                                   context:nil];
  
  return CGRectGetHeight(rect) + 2 * offset;
}

@end
