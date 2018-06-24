//
//  AZCheckers.m
//  Project WoodCheckers
//
//  Created by Alex Alexandrov on 07.12.13.
//  Copyright (c) 2013 Alex Zbirnik. All rights reserved.
//

#import "AZCheckers.h"

@implementation AZCheckers

- (id)initWithFrameAndImage:(CGRect)frame andImage: (UIImage *) imageChess
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = imageChess;
    }
    return self;
}

/************************** rankin checkers **************************/

+ (void) rankingCheckers: (CGRect) rectCheckers  andDragView: (UIView *) dragView{
    
    UIImage *imgChess = [[UIImage alloc] init];
    rectCheckers = CGRectMake(0, 0, 40, 40);

    for(NSInteger i = 0; i < 8; i++){
        
        if(i < 3){
            
            imgChess = [UIImage imageNamed:@"chessWhite.png"];
        }
        else if(i > 4 ){
            
            imgChess = [UIImage imageNamed:@"chessBlack.png"];
        }
        else{
            
            rectCheckers.origin.y +=40;
            continue;
        }
        
        for(NSInteger j = 0; j < 4; j++){
            
            UIView * viewChess = [[UIView alloc] initWithFrame:rectCheckers];
            viewChess.backgroundColor = [UIColor clearColor];
            [dragView addSubview:viewChess];
            
            UIImageView *imageViewChess = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
            imageViewChess.image = imgChess;
            [viewChess addSubview:imageViewChess];
            
            rectCheckers.origin.x += 2*CGRectGetWidth(rectCheckers);
            
        }
        (i%2) ? (rectCheckers.origin.x = 0) : (rectCheckers.origin.x = CGRectGetWidth(rectCheckers));
        rectCheckers.origin.y += CGRectGetWidth(rectCheckers);
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
