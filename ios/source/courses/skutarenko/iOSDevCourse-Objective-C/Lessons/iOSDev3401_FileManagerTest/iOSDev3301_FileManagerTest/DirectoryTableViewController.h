//
//  DirectoryTableViewController.h
//  iOSDev3301_FileManagerTest
//
//  Created by Oleg Tverdokhleb on 29.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DirectoryTableViewController : UITableViewController

@property (strong, nonatomic) NSString *path;

- (instancetype)initWithFolderPath:(NSString *)path;

- (IBAction)actionInfoCell:(UIButton *)sender;

@end