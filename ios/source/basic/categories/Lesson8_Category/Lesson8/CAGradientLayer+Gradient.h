//
//  CAGradientLayer+Gradient.h
//  Lesson8
//
//  Created by Oleg Tverdokhleb on 08.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CAGradientLayer (Gradient)

+ (CAGradientLayer *)setGradientLayer:(UIColor *)topColor
                       andBottomColor:(UIColor *)bottomColor;

@end
