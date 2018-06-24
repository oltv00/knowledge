//
//  ASDirectoryViewController.h
//  FileManagerTest
//
//  Created by Oleksii Skutarenko on 26.12.13.
//  Copyright (c) 2013 Alex Skutarenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASDirectoryViewController : UITableViewController

@property (strong, nonatomic) NSString* path;

- (id) initWithFolderPath:(NSString*) path;


- (IBAction) actionInfoCell:(id)sender;

@end
