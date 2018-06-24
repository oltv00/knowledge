//
//  InfoViewController.h
//  iOSDev3601_UIPopover
//
//  Created by Oleg Tverdokhleb on 03.05.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController

@property (strong, nonatomic) NSString *topDescriptionLabel;
@property (strong, nonatomic) NSString *centerDescriptionLabel;
@property (assign, nonatomic) BOOL showOkButton;
@property (assign, nonatomic) BOOL showNavigationBar;

- (IBAction)actionOK:(UIBarButtonItem *)sender;

@end
