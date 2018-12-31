//
//  AZCheckers.h
//  Project WoodCheckers
//
//  Created by Alex Alexandrov on 07.12.13.
//  Copyright (c) 2013 Alex Zbirnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AZCheckers : UIImageView

- (id)initWithFrameAndImage:(CGRect)frame andImage: (UIImage *) imageChess;

+ (void) rankingCheckers: (CGRect) rectCheckers  andDragView: (UIView *) dragView;

@end
