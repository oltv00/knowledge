//
//  UIAlertController+Utils.h
//  Test-centr-delovih-innovacii
//
//  Created by Oleg Tverdokhleb on 11/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Utils)

+ (void)showAlert:(NSString *)title message:(NSString *)message inVC:(UIViewController *)vc;

@end
