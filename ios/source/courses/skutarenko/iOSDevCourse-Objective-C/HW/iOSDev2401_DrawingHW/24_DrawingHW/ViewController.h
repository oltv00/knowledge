//
//  ViewController.h
//  24_DrawingHW
//
//  Created by Oleg Tverdokhleb on 18.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DrawingView;

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet DrawingView *drawingView;
@end

