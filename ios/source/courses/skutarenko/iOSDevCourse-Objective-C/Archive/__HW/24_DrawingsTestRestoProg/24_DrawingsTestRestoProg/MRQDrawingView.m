//
//  MRQDrawingView.m
//  24_DrawingsTestRestoProg
//
//  Created by Oleg Tverdokhleb on 12.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQDrawingView.h"

@implementation MRQDrawingView

- (void) drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat xCoordinateOfRect = (NSInteger)arc4random() % (NSInteger)CGRectGetWidth(rect);
    CGFloat yCoordinateOfRect = (NSInteger)arc4random() % (NSInteger)CGRectGetHeight(rect);
    
    CGFloat widthOfClearRect = CGRectGetWidth(rect) / 3;
    CGFloat heightOfClearRect = CGRectGetHeight(rect) / 3;
    
    //Инициализация переменных
    CGRect clearRect = CGRectMake(xCoordinateOfRect, yCoordinateOfRect, widthOfClearRect, heightOfClearRect);
    CGFloat arcRadius = CGRectGetWidth(clearRect) / 10;
    
    CGPoint starPoint1 = CGPointMake(CGRectGetMinX(clearRect), CGRectGetMaxY(clearRect));
    CGPoint starPoint2 = CGPointMake(CGRectGetMidX(clearRect), CGRectGetMinY(clearRect));
    CGPoint starPoint3 = CGPointMake(CGRectGetMaxX(clearRect), CGRectGetMaxY(clearRect));
    CGPoint starPoint4 = CGPointMake(CGRectGetMinX(clearRect), CGRectGetMidY(clearRect) / 1.25f);
    CGPoint starPoint5 = CGPointMake(CGRectGetMaxX(clearRect), CGRectGetMidY(clearRect) / 1.25f);
    
    // Установка опций для площади
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextAddRect(context, clearRect);
    CGContextStrokePath(context);
    
    // Установка опций для линии
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextSetLineWidth(context, 2.f);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextMoveToPoint(context, starPoint1.x, starPoint1.y);
    CGContextAddLineToPoint(context, starPoint2.x, starPoint2.y);
    CGContextAddLineToPoint(context, starPoint3.x, starPoint3.y);
    CGContextAddLineToPoint(context, starPoint4.x, starPoint4.y);
    CGContextAddLineToPoint(context, starPoint5.x, starPoint5.y);
    CGContextAddLineToPoint(context, starPoint1.x, starPoint1.y);
    
    CGContextStrokePath(context);
    
    //Окружности
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextMoveToPoint(context, starPoint1.x + arcRadius, starPoint1.y);
    CGContextAddArc(context, starPoint1.x, starPoint1.y, arcRadius, 0, M_PI * 2, NO);
    
    CGContextMoveToPoint(context, starPoint2.x + arcRadius, starPoint2.y);
    CGContextAddArc(context, starPoint2.x, starPoint2.y, arcRadius, 0, M_PI * 2, NO);

    CGContextMoveToPoint(context, starPoint3.x + arcRadius, starPoint3.y);
    CGContextAddArc(context, starPoint3.x, starPoint3.y, arcRadius, 0, M_PI * 2, NO);

    CGContextMoveToPoint(context, starPoint4.x + arcRadius, starPoint4.y);
    CGContextAddArc(context, starPoint4.x, starPoint4.y, arcRadius, 0, M_PI * 2, NO);

    CGContextMoveToPoint(context, starPoint5.x + arcRadius, starPoint5.y);
    CGContextAddArc(context, starPoint5.x, starPoint5.y, arcRadius, 0, M_PI * 2, NO);

    CGContextStrokePath(context);
    
    //Линии
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetLineWidth(context, 2.f);
    CGContextSetLineCap(context, kCGLineCapRound);

    CGContextMoveToPoint(context, starPoint1.x, starPoint1.y);
    CGContextAddLineToPoint(context, starPoint4.x, starPoint4.y);
    CGContextAddLineToPoint(context, starPoint2.x, starPoint2.y);
    CGContextAddLineToPoint(context, starPoint5.x, starPoint5.y);
    CGContextAddLineToPoint(context, starPoint3.x, starPoint3.y);
    CGContextAddLineToPoint(context, starPoint1.x, starPoint1.y);

    CGContextStrokePath(context);
}

@end
