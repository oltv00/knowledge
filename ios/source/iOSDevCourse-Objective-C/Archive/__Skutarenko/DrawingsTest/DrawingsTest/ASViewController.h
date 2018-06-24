//
//  ASViewController.h
//  DrawingsTest
//
//  Created by Oleksii Skutarenko on 02.12.13.
//  Copyright (c) 2013 Alex Skutarenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASDrawingView;

@interface ASViewController : UIViewController

@property (weak, nonatomic) IBOutlet ASDrawingView* drawingView;

@end
