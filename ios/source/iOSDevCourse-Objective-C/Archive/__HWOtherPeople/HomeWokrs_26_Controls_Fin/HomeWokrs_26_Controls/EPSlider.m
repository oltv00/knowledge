//
//  EPSlider.m
//  HomeWokrs_26_Controls
//
//  Created by Admin on 27.04.15.
//  Copyright (c) 2015 Evgenii Penkrat. All rights reserved.
//

#import "EPSlider.h"

@implementation EPSlider

- (id)initWithFrame:(CGRect)frame id:(EPSliderId) id andIdGruop:(EPSliderIdGroup) idGruop
{
    self = [super initWithFrame:frame];
    if (self) {
        self.id = id;
        self.idGruop = idGruop;
    }
    return self;
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
