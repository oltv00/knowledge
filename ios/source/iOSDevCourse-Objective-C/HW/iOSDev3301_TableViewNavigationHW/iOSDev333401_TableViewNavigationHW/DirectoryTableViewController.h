//
//  DirectoryTableViewController.h
//  iOSDev333401_TableViewNavigationHW
//
//  Created by Oleg Tverdokhleb on 30.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DirectoryTableViewController : UITableViewController

@property (strong, nonatomic) NSString *path;

@property (assign, nonatomic) BOOL showHiddenFiles;
@property (assign, nonatomic) BOOL showFolderSize;

- (void)refreshContents;
- (void)saveSettings;

@end
