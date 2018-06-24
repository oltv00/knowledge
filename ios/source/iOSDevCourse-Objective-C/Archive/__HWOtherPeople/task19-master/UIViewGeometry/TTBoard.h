//
//  TTBoard.h
//  UIViewGeometry
//
//  Created by sergey on 2/9/14.
//  Copyright (c) 2014 sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTBoard : UIView

- (UIView *)initBoardWithSize:(CGRect)rect numberOfCells:(NSUInteger)number;
- (void)changeColorBoardWithOrientation:(UIInterfaceOrientation)orientation;

@end
