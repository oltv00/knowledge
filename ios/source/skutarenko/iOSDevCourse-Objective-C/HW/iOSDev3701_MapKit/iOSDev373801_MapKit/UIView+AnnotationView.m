//
//  UIView+AnnotationView.m
//  iOSDev373801_MapKit
//
//  Created by Oleg Tverdokhleb on 09/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "UIView+AnnotationView.h"
#import <MapKit/MKAnnotationView.h>

@implementation UIView (AnnotationView)

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
