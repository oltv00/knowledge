//
//  UIView+UITableViewCell.m
//  iOSDev3301_FileManagerTest
//
//  Created by Oleg Tverdokhleb on 30.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "UIView+UITableViewCell.h"

@implementation UIView (UITableViewCell)

- (UITableViewCell *)superCell {

  if (!self.superview) {
    return nil;
  }
  
  if ([self.superview isKindOfClass:[UITableViewCell class]]) {
    return (UITableViewCell *)self.superview;
  }
  
  return [self.superview superCell];
}

@end
