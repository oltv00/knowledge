//
//  TableViewController.h
//  33-34_UITableViewNavigationRestoProg
//
//  Created by Oleg Tverdokhleb on 08.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController

@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editBarButtonItem;

- (id) initWithPath:(NSString *) path;

- (IBAction)actionEditBarButtonPressed:(UIBarButtonItem *)sender;

@end
