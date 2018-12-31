//
//  AZBlackCellView.h
//  Project WoodCheckers
//
//  Created by Alex Alexandrov on 07.12.13.
//  Copyright (c) 2013 Alex Zbirnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AZBlackCellView : UIView

@property (assign, nonatomic) BOOL occupiedCell;
@property (strong, nonatomic) NSString *colorChecker; // @"white" or @"black"
@property (strong, nonatomic) NSMutableArray *heapBlackCell;

- (void) createBlackCell:(CGRect)blackRect andDragView: (UIView *) dragView;
- (BOOL) blackCellFreeOrNot: (CGPoint) pointBegin andPointDrop: (CGPoint) pointDrop;
- (CGPoint) getBlackCellPoint: (CGPoint) pointDrop;
- (BOOL) noTouchBlackCell: (UIView *) touchView;
- (void) lightingCell;
- (void) returnColorCell;

@end
