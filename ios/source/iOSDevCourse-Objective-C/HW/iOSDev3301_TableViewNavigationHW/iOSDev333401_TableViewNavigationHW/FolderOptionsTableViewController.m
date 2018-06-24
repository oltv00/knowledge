//
//  FolderOptionsTableViewController.m
//  iOSDev333401_TableViewNavigationHW
//
//  Created by Oleg Tverdokhleb on 30.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "FolderOptionsTableViewController.h"
#import "DirectoryTableViewController.h"

@interface FolderOptionsTableViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *showHiddenFilesSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *showFolderSizeSwitch;

- (IBAction)actionShowHiddenFiles:(UISwitch *)sender;
- (IBAction)actionShowFolderSize:(UISwitch *)sender;

@end

@implementation FolderOptionsTableViewController

#pragma mark - View lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.showHiddenFilesSwitch setOn:self.showHiddenFiles];
  [self.showFolderSizeSwitch setOn:self.showFolderSize];
}

#pragma mark - Action

- (IBAction)actionDone:(UIBarButtonItem *)sender {
  __weak FolderOptionsTableViewController *weakSelf = self;
  [self dismissViewControllerAnimated:YES completion:^{
    [weakSelf.directoryController refreshContents];
  }];
}

- (IBAction)actionShowHiddenFiles:(UISwitch *)sender {
  self.directoryController.showHiddenFiles = sender.on;
  [self.directoryController saveSettings];
}

- (IBAction)actionShowFolderSize:(UISwitch *)sender {
  self.directoryController.showFolderSize = sender.on;
  [self.directoryController saveSettings];
}

@end
