//
//  UIAlertController+Utils.m
//  Test-centr-delovih-innovacii
//
//  Created by Oleg Tverdokhleb on 11/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "Utils.h"

@implementation UIAlertController (Utils)

+ (void)showAlert:(NSString *)title message:(NSString *)message inVC:(UIViewController *)vc {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
  [alert addAction:ok];
  [vc presentViewController:alert animated:YES completion:nil];
}

@end
