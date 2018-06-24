//
//  ASDrawingView.m
//  DrawingsTest
//
//  Created by Oleksii Skutarenko on 02.12.13.
//  Copyright (c) 2013 Alex Skutarenko. All rights reserved.
//

#import "ASDrawingView.h"

@implementation ASDrawingView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //[super drawRect:rect];
    
    NSLog(@"drawRect %@", NSStringFromCGRect(rect));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /*
    
    CGRect square1 = CGRectMake(100, 100, 100, 100);
    CGRect square2 = CGRectMake(200, 200, 100, 100);
    CGRect square3 = CGRectMake(300, 300, 100, 100);
    
    
    //CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextAddRect(context, square1);
    CGContextAddRect(context, square2);
    CGContextAddRect(context, square3);
    
    //CGContextFillPath(context);
    CGContextStrokePath(context);
    
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    
    CGContextAddEllipseInRect(context, square1);
    CGContextAddEllipseInRect(context, square2);
    CGContextAddEllipseInRect(context, square3);
    
    CGContextFillPath(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGContextSetLineWidth(context, 1.f);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextMoveToPoint(context, CGRectGetMinX(square1), CGRectGetMaxY(square1));
    CGContextAddLineToPoint(context, CGRectGetMinX(square3), CGRectGetMaxY(square3));
    
    CGContextMoveToPoint(context, CGRectGetMaxX(square3), CGRectGetMinY(square3));
    CGContextAddLineToPoint(context, CGRectGetMaxX(square1), CGRectGetMinY(square1));
    
    CGContextStrokePath(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    
    CGContextMoveToPoint(context, CGRectGetMinX(square1), CGRectGetMaxY(square1));
    CGContextAddArc(context, CGRectGetMaxX(square1), CGRectGetMaxY(square1), CGRectGetWidth(square1), M_PI, 0, YES);
    
    CGContextMoveToPoint(context, CGRectGetMaxX(square3), CGRectGetMinY(square3));
    CGContextAddArc(context, CGRectGetMinX(square3), CGRectGetMinY(square3), CGRectGetWidth(square3), 0, M_PI, YES);
    
    CGContextStrokePath(context);
    
    NSString* text = @"test";
    
    UIFont* font = [UIFont systemFontOfSize:14.f];
    
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(1, 1);
    shadow.shadowColor = [UIColor whiteColor];
    shadow.shadowBlurRadius = 0.5;
    
    NSDictionary* attirbutes =
    [NSDictionary dictionaryWithObjectsAndKeys:
     [UIColor grayColor],   NSForegroundColorAttributeName,
     font,                  NSFontAttributeName,
     shadow,                NSShadowAttributeName, nil];
    
    CGSize textSize = [text sizeWithAttributes:attirbutes];
    
    CGRect textRect = CGRectMake(CGRectGetMidX(square2) - textSize.width / 2,
                                 CGRectGetMidY(square2) - textSize.height / 2,
                                 textSize.width, textSize.height);
    
    textRect = CGRectIntegral(textRect);
    
    [text drawInRect:textRect withAttributes:attirbutes];
    
    //[text drawAtPoint:CGPointMake(CGRectGetMidX(square2) - textSize.width / 2, CGRectGetMidY(square2) - textSize.height / 2) withAttributes:attirbutes];
    */
    
    CGFloat offset = 50.f;
    CGFloat borderWidth = 4.f;
    
    CGFloat maxBoardSize = MIN(CGRectGetWidth(rect) - offset * 2 - borderWidth * 2,
                               CGRectGetHeight(rect) - offset * 2 - borderWidth *2);
    
    int cellSize = (int)maxBoardSize / 8;
    int boardSize = cellSize * 8;
    
    CGRect boardRect = CGRectMake((CGRectGetWidth(rect) - boardSize) / 2,
                                  (CGRectGetHeight(rect) - boardSize) / 2,
                                  boardSize, boardSize);
    
    boardRect = CGRectIntegral(boardRect);
    
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            if (i % 2 != j % 2) {
                CGRect cellRect =
                CGRectMake(CGRectGetMinX(boardRect) + i * cellSize,
                           CGRectGetMinY(boardRect) + j * cellSize,
                           cellSize, cellSize);
                
                CGContextAddRect(context, cellRect);
            }
        }
    }
    
    
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    
    CGContextFillPath(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    
    CGContextAddRect(context, boardRect);
    
    CGContextSetLineWidth(context, borderWidth);
    
    CGContextStrokePath(context);
    
}

@end
