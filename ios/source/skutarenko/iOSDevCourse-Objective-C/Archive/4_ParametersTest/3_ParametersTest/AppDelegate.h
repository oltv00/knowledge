//
//  AppDelegate.h
//  3_ParametersTest
//
//  Created by Oleg Tverdokhleb on 04.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRQObject;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (nonatomic, weak) MRQObject* object;


@end

