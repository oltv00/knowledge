//
//  DismissSegue.m
//  Lesson36-HOmeWork
//
//  Created by Nick Bibikov on 1/15/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import "DismissSegue.h"

@implementation DismissSegue

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    [sourceViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
