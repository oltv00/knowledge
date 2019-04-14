//
//  AppDelegate.h
//  4_ParametersTest
//
//  Created by Oleg Tverdokhleb on 28.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OTObject;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) OTObject *strong;
@property (weak, nonatomic) OTObject *weak;
@property (copy, nonatomic) OTObject *copyyy;
@property (assign, nonatomic) NSInteger objectID;

@end

