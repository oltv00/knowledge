//
//  UITableViewCell+HeightForText.m
//  iOSDev4501_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 10/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "UITableViewCell+HeightForText.h"

@implementation UITableViewCell (HeightForText)

- (CGFloat)heightForText:(NSString*)text {
  
  CGFloat offset = 5.0;
  
  UIFont* font = [UIFont fontWithName:@"Georgia" size:13.f];
  
  
  NSMutableParagraphStyle* paragraph = [[NSMutableParagraphStyle alloc] init];
  [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
  [paragraph setAlignment:NSTextAlignmentLeft];
  
  NSDictionary* attributes =
  [NSDictionary dictionaryWithObjectsAndKeys:
   font, NSFontAttributeName,
   paragraph, NSParagraphStyleAttributeName, nil];
  
  
  CGRect rect = [text boundingRectWithSize:CGSizeMake(320 - 2 * offset, CGFLOAT_MAX)
                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                attributes:attributes
                                   context:nil];
  
  
  return CGRectGetHeight(rect);
}

@end
