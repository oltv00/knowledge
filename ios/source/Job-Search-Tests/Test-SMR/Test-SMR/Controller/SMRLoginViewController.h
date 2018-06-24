//
//  SMRLoginViewController.h
//  Test-centr-delovih-innovacii
//
//  Created by Oleg Tverdokhleb on 11/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SMRLoginViewControllerDelegate;

@interface SMRLoginViewController : UIViewController
@property (weak, nonatomic) id <SMRLoginViewControllerDelegate> delegate;
@end

@protocol SMRLoginViewControllerDelegate <NSObject>
- (void)SMRLoginDidFinishLogin;
@end
