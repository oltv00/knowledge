//
//  DetailedViewController.h
//  Lesson7
//
//  Created by Oleg Tverdokhleb on 07.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailedViewController : UIViewController

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *currentEvent;
@property (assign, nonatomic) BOOL isNewEvent;

@end
