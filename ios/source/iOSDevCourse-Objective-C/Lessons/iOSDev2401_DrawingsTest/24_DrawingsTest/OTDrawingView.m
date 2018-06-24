//
//  OTDrawingView.m
//  24_DrawingsTest
//
//  Created by Oleg Tverdokhleb on 17.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTDrawingView.h"

@interface OTDrawingView ()

@end

@implementation OTDrawingView
- (void)drawRect:(CGRect)rect {
    NSLog(@"drawRect: %@", NSStringFromCGRect(rect));
//    [self level1:rect];
//    [self level2:rect];
    [self level3:rect];
}

- (void)level3:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat offset = 20.f;
    CGFloat borderWidth = 2.f;
    
    CGFloat maxBoardSize = MIN(CGRectGetWidth(rect) - offset * 2 - borderWidth * 2,
                               CGRectGetHeight(rect) - offset * 2 - borderWidth * 2);
    int cellSize = (int)maxBoardSize / 8;
    int boardSize = cellSize * 8;
    
    CGRect boardRect = CGRectMake((CGRectGetWidth(rect) - boardSize) / 2,
                                  (CGRectGetHeight(rect) - boardSize) / 2,
                                  boardSize, boardSize);
    
    boardRect = CGRectIntegral(boardRect);
    
    for (int i = 0; i < 8; i += 1) {
        for (int j = 0; j < 8; j += 1) {
            if (i % 2 != j % 2) {
                CGRect cellRect = CGRectMake(CGRectGetMinX(boardRect) + i * cellSize,
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

- (void)level2:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect frame1 = CGRectMake(20, 20, 80, 80);
    CGRect frame2 = CGRectMake(100, 100, 80, 80);
    CGRect frame3 = CGRectMake(180, 180, 80, 80);
    
    //squares
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 1.f);
    
    CGContextAddRect(context, frame1);
    CGContextAddRect(context, frame2);
    CGContextAddRect(context, frame3);
    CGContextStrokePath(context);
    
    //ellipses
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextAddEllipseInRect(context, frame1);
    CGContextAddEllipseInRect(context, frame2);
    CGContextAddEllipseInRect(context, frame3);
    
    CGContextFillPath(context);
    
    //lines
    CGContextSetLineWidth(context, 1.f);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextMoveToPoint(context, CGRectGetMinX(frame1), CGRectGetMaxY(frame1));
    CGContextAddLineToPoint(context, CGRectGetMinX(frame3), CGRectGetMaxY(frame3));
    
    CGContextMoveToPoint(context, CGRectGetMaxX(frame3), CGRectGetMinY(frame3));
    CGContextAddLineToPoint(context, CGRectGetMaxX(frame1), CGRectGetMinY(frame1));
    
    CGContextStrokePath(context);
    
    //arc
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    
    CGContextMoveToPoint(context, CGRectGetMaxX(frame1), CGRectGetMaxY(frame1));
    CGContextAddArc(context, CGRectGetMaxX(frame1), CGRectGetMaxY(frame1), CGRectGetWidth(frame1), M_PI, 0, YES);
    
    CGContextMoveToPoint(context, CGRectGetMinX(frame3), CGRectGetMinY(frame3));
    CGContextAddArc(context, CGRectGetMinX(frame3), CGRectGetMinY(frame3), CGRectGetWidth(frame3), 0, M_PI, YES);
    
    CGContextStrokePath(context);
    
    //text
    NSString *text = @"HELLO WORLD!";
    UIFont *font = [UIFont systemFontOfSize:14];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(1, 1);
    shadow.shadowColor = [UIColor whiteColor];
    shadow.shadowBlurRadius = 0.5f;
    
    NSDictionary *attributes = @{NSFontAttributeName            :   font,
                                 NSForegroundColorAttributeName :   [UIColor grayColor],
                                 NSShadowAttributeName          :   shadow};
    
    CGSize size = [text sizeWithAttributes:attributes];
    CGPoint point = CGPointMake(CGRectGetMidX(frame2) - size.width / 2, CGRectGetMidY(frame2) - size.height / 2);
    
    //Можно делать так
    //[text drawAtPoint:point withAttributes:attributes];
    
    //А можно так! Так делать в случае если текст слишком сильно размыт
    CGRect textRect = CGRectMake(point.x, point.y, size.width, size.height);
    //Округляет значения
    textRect = CGRectIntegral(textRect);
    [text drawInRect:textRect withAttributes:attributes];
}

- (void)level1:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //stroke - границы
    //fill - заполнить
    
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    
    //1
    CGContextFillRect(context, rect);
    
    //2
    CGContextAddRect(context, rect);
    CGContextFillPath(context);
}

@end
