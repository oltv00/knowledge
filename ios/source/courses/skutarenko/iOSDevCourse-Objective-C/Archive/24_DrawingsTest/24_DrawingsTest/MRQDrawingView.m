//
//  MRQDrawingView.m
//  24_DrawingsTest
//
//  Created by Oleg Tverdokhleb on 12.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQDrawingView.h"

@implementation MRQDrawingView

- (void) drawRect:(CGRect)rect {
    
    // Метод который вызывается каждый раз когда view перересовывается

    //Fill - заполняет
    //Stroke - чертит границы

    //1 способ
    //CGContextAddRect(context, rect);
    //CGContextFillPath(context);
    
    // 2 способ
    //CGContextFillRect(context, rect);

    NSLog(@"drawRect: %@", NSStringFromCGRect(rect));
    
    CGContextRef context = UIGraphicsGetCurrentContext(); // Создаем context
    
    //CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor); // Context fill в другой цвет
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor); // Context stroke в другой цвет
 
    CGRect square1 = CGRectMake(100, 100, 100, 100);
    CGRect square2 = CGRectMake(200, 200, 100, 100);
    CGRect square3 = CGRectMake(300, 300, 100, 100);
    
    CGContextAddRect(context, square1); // Создаем 3 CGRects
    CGContextAddRect(context, square2);
    CGContextAddRect(context, square3);

    //CGContextFillPath(context); // заполняет их на view
    CGContextStrokePath(context); // чертит границы на view
    
    //Круги
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    
    CGContextAddEllipseInRect(context, square1);
    CGContextAddEllipseInRect(context, square2);
    CGContextAddEllipseInRect(context, square3);
    
    CGContextFillPath(context);
    
    //Линии
    CGContextSetStrokeColorWithColor(context, [UIColor  blueColor].CGColor);
    CGContextSetLineWidth(context, 2.f);
    CGContextSetLineCap(context, kCGLineCapRound); // закругление конца линии
    
    CGContextMoveToPoint(context, CGRectGetMinX(square1), CGRectGetMaxY(square1));
    CGContextAddLineToPoint(context, CGRectGetMinX(square3), CGRectGetMaxY(square3));

    CGContextMoveToPoint(context, CGRectGetMaxX(square3), CGRectGetMinX(square3));
    CGContextAddLineToPoint(context, CGRectGetMaxX(square1), CGRectGetMinY(square1));

    CGContextStrokePath(context);
    
    //Окружности
    CGContextMoveToPoint(context, CGRectGetMaxX(square1), CGRectGetMaxY(square1));
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextAddArc(context, CGRectGetMaxX(square1), CGRectGetMaxY(square1), CGRectGetWidth(square1), M_PI, M_PI_2, YES);
    
    CGContextMoveToPoint(context, CGRectGetMaxX(square2), CGRectGetMaxY(square2));
    CGContextAddArc(context, CGRectGetMaxX(square2), CGRectGetMaxY(square2), CGRectGetWidth(square2), 3 * M_PI_2, 0.f, NO);
    CGContextStrokePath(context);
    
    //Текст
    NSString *text = @"test";                       //Сам текст
    UIFont *font = [UIFont systemFontOfSize:14.f];  //Размер текста
    UIColor *fontColor = [UIColor grayColor];       //Цвет текста
    NSShadow *shadow = [[NSShadow alloc] init];     //Создание объекта тень
    shadow.shadowOffset = CGSizeMake(1.f, 1.f);     //Размер тени
    shadow.shadowColor = [UIColor whiteColor];      //Цвет тени
    shadow.shadowBlurRadius = 0.5f;                 //Радиус блюр (размытость)
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                font,       NSFontAttributeName,
                                fontColor,  NSForegroundColorAttributeName,
                                shadow,     NSShadowAttributeName,
                                nil];
    CGSize textSize = [text sizeWithAttributes:attributes];
    
    //[text drawAtPoint:CGPointMake(CGRectGetMidX(square2) - textSize.width / 2,
    //                              CGRectGetMidY(square2) - textSize.height / 2)
    //   withAttributes:attributes]; // Так лучше не делать, т.к. текст может быть сильно размытым
    
    CGRect textRect = CGRectMake(CGRectGetMidX(square2) - textSize.width / 2,
                                 CGRectGetMidY(square2) - textSize.height / 2,
                                 textSize.width, textSize.height);
    textRect = CGRectIntegral(textRect); //Преобразует дробные значения в целые
    [text drawInRect:textRect withAttributes:attributes];
}

@end
