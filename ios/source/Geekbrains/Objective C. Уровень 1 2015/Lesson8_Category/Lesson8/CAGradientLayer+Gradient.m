//
//  CAGradientLayer+Gradient.m
//  Lesson8
//
//  Created by Oleg Tverdokhleb on 08.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "CAGradientLayer+Gradient.h"

@implementation CAGradientLayer (Gradient)

+ (CAGradientLayer *)setGradientLayer:(UIColor *)topColor
                      andBottomColor:(UIColor *)bottomColor {

    NSArray *gradientsColors = [NSArray arrayWithObjects:
                                (id)topColor.CGColor,
                                (id)bottomColor.CGColor, nil];

    NSArray *gradientLocations = [NSArray arrayWithObjects:
                                  [NSNumber numberWithInt:0.0],
                                  [NSNumber numberWithInt:1.0], nil];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = gradientsColors;
    gradientLayer.locations = gradientLocations;
    
    return gradientLayer;
}

@end
