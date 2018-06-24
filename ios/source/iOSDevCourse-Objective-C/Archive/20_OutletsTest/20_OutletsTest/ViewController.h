//
//  ViewController.h
//  20_OutletsTest
//
//  Created by Oleg Tverdokhleb on 27.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *viewsTestColl;

@end

