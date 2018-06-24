//
//  EPSlider.h
//  HomeWokrs_26_Controls
//
//  Created by Admin on 27.04.15.
//  Copyright (c) 2015 Evgenii Penkrat. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EPSliderIdGroup) {
    EPSSliderIdGroupSanta     = 0,
};

typedef NS_ENUM(NSUInteger, EPSliderId) {
    EPSliderIdSpeed     = 0,
};

@interface EPSlider : UISlider

@property (assign, nonatomic) EPSliderId id;
@property (assign, nonatomic) EPSliderIdGroup idGruop;

- (id)initWithFrame:(CGRect)frame id:(EPSliderId) id andIdGruop:(EPSliderIdGroup) idGruop;

@end
