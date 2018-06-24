//
//  UIView+UICollectionViewCell.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 05/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "UIView+UICollectionViewCell.h"

@implementation UIView (UICollectionViewCell)

- (UICollectionViewCell *)superCollectionViewCell {
  
  if (!self.superview) {
    return nil;
  }
  
  if ([self.superview isKindOfClass:[UICollectionViewCell class]]) {
    return (UICollectionViewCell *)self.superview;
  }
  
  return [self.superview superCollectionViewCell];
  
}

@end
