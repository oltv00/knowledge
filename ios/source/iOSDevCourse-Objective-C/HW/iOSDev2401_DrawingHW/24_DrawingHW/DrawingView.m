//
//  DrawingView.m
//  24_DrawingHW
//
//  Created by Oleg Tverdokhleb on 18.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "DrawingView.h"

@implementation DrawingView
- (void)drawRect:(CGRect)rect {
    NSLog(@"Draw rect %@", NSStringFromCGRect(rect));

//    [self levelLearner:rect];
    [self levelStudent:rect];
//    [self levelMaster:rect];
}

#pragma mark - Additional
- (UIColor *)randomColor {
    CGFloat r = (CGFloat)arc4random_uniform(256)/255;
    CGFloat g = (CGFloat)arc4random_uniform(256)/255;
    CGFloat b = (CGFloat)arc4random_uniform(256)/255;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

#pragma mark - LevelMaster
- (void)levelMaster:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //axis lines
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 1.f);
    
    //x
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMidY(rect));
    
    //y
    CGContextMoveToPoint(context, CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(context, CGRectGetMidX(rect), CGRectGetMaxY(rect));
    CGContextStrokePath(context);
    
    //sin
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    for (double i = -1; i <= 1; i += 1) {
        CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect));
        
        NSUInteger x = sin(i);
        NSUInteger y = -sin(i);
        CGContextAddLineToPoint(context, x, y);
    }
    CGContextStrokePath(context);
}

#pragma mark - LevelStudent
- (void)levelStudent:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int i = 0; i < 5; i += 1) {
        [self drawStarWithContext:context rect:rect];
    }
}

- (void)drawStarWithContext:(CGContextRef)context rect:(CGRect)rect {
    
    NSUInteger n = 5; //star vertices
    NSUInteger k = 2; //number of vertices, which counted for drawing hand
    
    //radius of star and circle
    NSUInteger radius = 50 + arc4random_uniform(51);
    NSUInteger circleRadius = 10 + arc4random_uniform(11);
    
    //center of star
    CGPoint center;
    center.x = arc4random()%((NSUInteger)CGRectGetWidth(rect) - 2*radius - 2*circleRadius) + radius + circleRadius;
    center.y = arc4random()%((NSUInteger)CGRectGetHeight(rect) - 2*radius - 2*circleRadius) + radius + circleRadius;
    
    //first vertice angle 90
    CGFloat angle = 3*M_PI/2;
    
    NSMutableArray *points = [NSMutableArray array];
    //draw the star
    CGContextSetFillColorWithColor(context, [self randomColor].CGColor);
    CGPoint firstPoint = CGPointMake(center.x, center.y - radius);
    CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
    CGPoint point;
    
    for (int i = 0; i <= n - 1; i += 1) {
        point.x = center.x + radius*cos(2*M_PI/n*(k*i) + angle);
        point.y = center.y + radius*sin(2*M_PI/n*(k*i) + angle);
        [points addObject:[NSValue valueWithCGPoint:point]];
        
        CGContextAddLineToPoint(context, point.x, point.y);
    }
    CGContextAddLineToPoint(context, firstPoint.x, firstPoint.y);
    CGContextFillPath(context);
    
    //draw circles
    for (int i = 0; i <= n - 1; i += 1) {
        point = [points[i] CGPointValue];
        CGContextSetStrokeColorWithColor(context, [self randomColor].CGColor);
        CGContextMoveToPoint(context, point.x+circleRadius, point.y);
        CGContextAddArc(context, point.x, point.y, circleRadius, 0, 2*M_PI, 0);
    }
    CGContextStrokePath(context);
    
    //draw polygon
    CGContextSetStrokeColorWithColor(context, [self randomColor].CGColor);
    CGContextSetLineWidth(context, 1);
    CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
    for (int  i = 0; i <= n - 1; i += 1) {
        point.x = center.x + radius*cos(2*M_PI/n*(i) + angle);
        point.y = center.y + radius*sin(2*M_PI/n*(i) + angle);
        CGContextAddLineToPoint(context, point.x, point.y);
    }
    CGContextAddLineToPoint(context, firstPoint.x, firstPoint.y);
    CGContextStrokePath(context);
}

#pragma mark - LevelLearner
- (void)levelLearner:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //add star rect
    CGFloat offset = 100.f;
    CGFloat width = MIN(CGRectGetWidth(rect) - offset, CGRectGetHeight(rect) - offset); //CGFloat width = CGRectGetWidth(rect) - offset;
    CGFloat height = width;
    CGFloat x = CGRectGetMidX(rect) - width / 2;
    CGFloat y = CGRectGetMidY(rect) - height / 2;
    
    CGRect starRect = CGRectMake(x, y, width, height);
    
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextAddRect(context, starRect);
    CGContextStrokePath(context);
    
    //add star
    CGContextSetLineWidth(context, 2.f);
    CGContextSetLineCap(context, 0.5f);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    //star points
    CGPoint point1 = CGPointMake(CGRectGetMinX(starRect), CGRectGetMaxY(starRect));
    CGPoint point2 = CGPointMake(CGRectGetMidX(starRect), CGRectGetMinY(starRect));
    CGPoint point3 = CGPointMake(CGRectGetMaxX(starRect), CGRectGetMaxY(starRect));
    CGPoint point4 = CGPointMake(CGRectGetMinX(starRect), CGRectGetMidY(starRect) - height/8);
    CGPoint point5 = CGPointMake(CGRectGetMaxX(starRect), CGRectGetMidY(starRect) - height/8);
    
    CGContextMoveToPoint(context, point1.x, point1.y);
    CGContextAddLineToPoint(context, point2.x, point2.y);
    CGContextAddLineToPoint(context, point3.x, point3.y);
    CGContextAddLineToPoint(context, point4.x, point4.y);
    CGContextAddLineToPoint(context, point5.x, point5.y);
    CGContextAddLineToPoint(context, point1.x, point1.y);
    
    CGContextStrokePath(context);
    
    //add circles
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGFloat radius = width / 5;
    CGFloat startAngle = 0;
    CGFloat endAngle = (float)(2*M_PI);
    
    CGContextMoveToPoint(context, point1.x + radius, point1.y);
    CGContextAddArc(context, point1.x, point1.y, radius, startAngle, endAngle, YES);
    
    CGContextMoveToPoint(context, point2.x + radius, point2.y);
    CGContextAddArc(context, point2.x, point2.y, radius, startAngle, endAngle, YES);
    
    CGContextMoveToPoint(context, point3.x + radius, point3.y);
    CGContextAddArc(context, point3.x, point3.y, radius, startAngle, endAngle, YES);

    CGContextMoveToPoint(context, point4.x + radius, point4.y);
    CGContextAddArc(context, point4.x, point4.y, radius, startAngle, endAngle, YES);

    CGContextMoveToPoint(context, point5.x + radius, point5.y);
    CGContextAddArc(context, point5.x, point5.y, radius, startAngle, endAngle, YES);

    CGContextStrokePath(context);
    
    //add lines to center of circles
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextSetLineWidth(context, 3.f);
    
    CGContextMoveToPoint(context, point1.x, point1.y);
    CGContextAddLineToPoint(context, point4.x, point4.y);
    CGContextAddLineToPoint(context, point2.x, point2.y);
    CGContextAddLineToPoint(context, point5.x, point5.y);
    CGContextAddLineToPoint(context, point3.x, point3.y);
    CGContextAddLineToPoint(context, point1.x, point1.y);
    
    CGContextStrokePath(context);

}

@end
