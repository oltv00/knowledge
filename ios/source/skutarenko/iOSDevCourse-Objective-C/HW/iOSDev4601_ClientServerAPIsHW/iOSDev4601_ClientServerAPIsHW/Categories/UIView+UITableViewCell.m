//
//  UIView+UITableViewCell.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 20/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "UIView+UITableViewCell.h"

@implementation UIView (UITableViewCell)

- (UITableViewCell *)superTableViewCell {
  if (!self.superview) {
    return nil;
  }
  
  if ([self.superview isKindOfClass:[UITableViewCell class]]) {
    return (UITableViewCell *)self.superview;
  }
  
  return [self.superview superTableViewCell];
}

@end
