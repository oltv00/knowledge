//
//  UIViewController+HideBackBarButtonItem.m
//  iOSDev4501_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 08/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "UIViewController+HideBackBarButtonItem.h"

@implementation UIViewController (HideBackBarButtonItem)

- (void)hideBackBarButtonItem {
  UIBarButtonItem *item = [[UIBarButtonItem alloc]
                           initWithTitle:@""
                           style:UIBarButtonItemStylePlain
                           target:nil action:nil];
  self.navigationItem.backBarButtonItem = item;
}

@end
