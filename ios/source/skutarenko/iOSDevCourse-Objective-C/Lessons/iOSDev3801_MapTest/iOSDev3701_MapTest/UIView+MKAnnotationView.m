//
//  UIView+MKAnnotationView.m
//  iOSDev3701_MapTest
//
//  Created by Oleg Tverdokhleb on 07.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "UIView+MKAnnotationView.h"
#import <MapKit/MKAnnotationView.h>

@implementation UIView (MKAnnotationView)

- (MKAnnotationView *)superAnnotationView {
  if ([self isKindOfClass:[MKAnnotationView class]]) {
    return (MKAnnotationView *)self;
  }
  if (!self.superview) {
    return nil;
  }
  return [self.superview superAnnotationView];
}

@end
