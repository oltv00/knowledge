//
//  MSMViewController.h
//  SearchBarHomeWork
//
//  Created by Admin on 05.03.14.
//  Copyright (c) 2014 Sergey Monastyrskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSMViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *homeBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *topBarButton;

- (IBAction)actionClickHomeButton:(UIBarButtonItem *)sender;
- (IBAction)actionClickTopButton:(UIBarButtonItem *)sender;

@end
