//
//  AZBlackCellView.m
//  Project WoodCheckers
//
//  Created by Alex Alexandrov on 07.12.13.
//  Copyright (c) 2013 Alex Zbirnik. All rights reserved.
//

#import "AZBlackCellView.h"

@implementation AZBlackCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.75f;
        self.occupiedCell = FALSE;
        
    }
    return self;
}

/******************************** create black cell in the desk ********************************/

- (void) createBlackCell:(CGRect)blackRect andDragView: (UIView *) dragView{
    
    self.heapBlackCell = [[NSMutableArray alloc] init];
    
    for(NSInteger i = 0; i < 8; i++){
        for(NSInteger j = 0; j < 4; j++){
            
            AZBlackCellView * blackCellView = [[AZBlackCellView alloc] initWithFrame:blackRect];
            
            if(i < 3 || i > 4){
                blackCellView.occupiedCell = TRUE;
                
            }
            
            [dragView addSubview:blackCellView];
            [self.heapBlackCell addObject:blackCellView];
            
            blackRect.origin.x += 2 * CGRectGetWidth(blackRect);
        }
        
        (i%2) ? (blackRect.origin.x = 0) : (blackRect.origin.x = CGRectGetWidth(blackRect));
        blackRect.origin.y += CGRectGetWidth(blackRect);
    }
  
}

- (BOOL) noTouchBlackCell: (UIView *) touchView{
    
    BOOL toTouchOrNotToTouch = TRUE;
    
    for(UIView * anyView in self.heapBlackCell){
        
        if([anyView isEqual:touchView]){
            
            toTouchOrNotToTouch = FALSE;
        }
    }
    
    return toTouchOrNotToTouch;
    
}

- (BOOL) blackCellFreeOrNot:(CGPoint) pointBegin andPointDrop: (CGPoint) pointDrop{
    
    BOOL toDragOrNotToDrag = TRUE;
    
    for(AZBlackCellView * anyBlackCell in self.heapBlackCell){
        
        if(CGRectContainsPoint(anyBlackCell.frame, pointDrop) && !anyBlackCell.occupiedCell){

            anyBlackCell.occupiedCell = TRUE;
            toDragOrNotToDrag = FALSE;
            
            [self noOccupiedCell:pointBegin];  
        }
  
    }
    return toDragOrNotToDrag;
}

- (void) noOccupiedCell: (CGPoint) pointBegin{
    
    for(AZBlackCellView * anyCell in self.heapBlackCell){
        
        if(CGRectContainsPoint(anyCell.frame, pointBegin)){
            
            anyCell.occupiedCell = FALSE;
        }
        
    }
    
}

- (CGPoint) getBlackCellPoint: (CGPoint) pointDrop{
    
    CGPoint pointBlackCell;
    
    for(AZBlackCellView * anyBlackCell in self.heapBlackCell){
        
        if(CGRectContainsPoint(anyBlackCell.frame, pointDrop)){
            
            pointBlackCell = anyBlackCell.frame.origin;
        }
    }
    
    return pointBlackCell;
}

/******************************** yellow light in black cell ********************************/

- (void) lightingCell{
    
    self.backgroundColor = [UIColor yellowColor];
    self.alpha = 0.4f;
    
}

/******************************** return black color in cell ********************************/

- (void) returnColorCell{
    
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.75f;
}

@end
