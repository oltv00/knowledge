//
//  EPSwitch.h
//  HomeWokrs_26_Controls
//
//  Created by Admin on 27.04.15.
//  Copyright (c) 2015 Evgenii Penkrat. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EPSwitchIdGroup) {
    EPSwitchIdGroupSanta     = 0,
};

typedef NS_ENUM(NSUInteger, EPSwitchId) {
    EPSwitchIdRotation     = 0,
    EPSwitchIdScale        = 1,
    EPSwitchIdTranslation  = 2,
};

@interface EPSwitch : UISwitch

@property (assign, nonatomic) EPSwitchId id;
@property (assign, nonatomic) EPSwitchIdGroup idGruop;


- (id)initWithFrame:(CGRect)frame id:(EPSwitchId) id andIdGruop:(EPSwitchIdGroup) idGruop;

@end
