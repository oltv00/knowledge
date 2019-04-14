//
//  FolderOptionsTableViewController.h
//  iOSDev333401_TableViewNavigationHW
//
//  Created by Oleg Tverdokhleb on 30.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DirectoryTableViewController;

@interface FolderOptionsTableViewController : UITableViewController

@property (weak, nonatomic) DirectoryTableViewController *directoryController;

@property (assign, nonatomic) BOOL showHiddenFiles;
@property (assign, nonatomic) BOOL showFolderSize;

@end