//
//  MRQDirectoryTableViewController.h
//  33_FileManagerTest
//
//  Created by Oleg Tverdokhleb on 06.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRQDirectoryTableViewController : UITableViewController

@property (strong, nonatomic) NSString *path;

- (id) initWithFolderPath:(NSString *) path;

@end
