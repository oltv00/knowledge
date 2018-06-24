//
//  DirectoryTableViewController.m
//  iOSDev333401_TableViewNavigationHW
//
//  Created by Oleg Tverdokhleb on 30.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

//Controllers
#import "DirectoryTableViewController.h"
#import "FolderOptionsTableViewController.h"

//UI
#import "FileTableViewCell.h"
#import "FolderTableViewCell.h"

//NSUserDefaults
NSString *const kShowHiddenFiles = @"kShowHiddenFiles";
NSString *const kShowFolderSize = @"kShowFolderSize";

@interface DirectoryTableViewController () <UINavigationControllerDelegate>

@property (strong, nonatomic) NSArray *contents;

- (IBAction)actionAddDirectory:(UIBarButtonItem *)sender;

@end

@implementation DirectoryTableViewController

#pragma mark - View lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  if (!self.path) {
    self.path = @"/Users/oltv00/Documents";
    self.showHiddenFiles = NO;
    self.showFolderSize = NO;
  }
  self.navigationItem.title = [self.path lastPathComponent];
  self.navigationController.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self addRefresh];
  [self refreshContents];
}

- (void)setPath:(NSString *)path {
  _path = path;
  self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
}

#pragma mark - Additional

- (void)refreshContents {
  [self loadSettings];
  [self updateContents];
  [self sortContents];
  [self.tableView reloadData];
  [self.refreshControl endRefreshing];
}

- (BOOL)isDirectoryAtPath:(NSString *)path {
  BOOL isDirectory = NO;
  [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
  return isDirectory;
}

- (BOOL)isDirectoryAtIndexPath:(NSIndexPath *)indexPath {
  BOOL isDirectory = NO;
  NSString *fileName = self.contents[indexPath.row];
  NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
  [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
  return isDirectory;
}

- (void)updateContents {
  if (!self.showHiddenFiles) {
    self.contents = [self showHiddenFiles:NO];
  } else {
    self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:nil];
  }
}

- (void)changeBarButtonItem {
  BOOL isEditing = self.tableView.editing;
  if (isEditing) {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(actionEdit:)];
    self.navigationItem.rightBarButtonItem = item;
  } else {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(actionEdit:)];
    self.navigationItem.rightBarButtonItem = item;
  }
  [self.tableView setEditing:!isEditing animated:YES];
}

- (void)sortContents {
  __weak DirectoryTableViewController *weakSelf = self;
  self.contents = [self.contents sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
    NSString *pathObj1 = [weakSelf.path stringByAppendingPathComponent:obj1];
    NSString *pathObj2 = [weakSelf.path stringByAppendingPathComponent:obj2];
    
    if ([weakSelf isDirectoryAtPath:pathObj1] && [weakSelf isDirectoryAtPath:pathObj2]) {

      if ([obj1 compare:obj2] == NSOrderedAscending) {
        return (NSComparisonResult)NSOrderedAscending;
      } else if ([obj1 compare:obj2] == NSOrderedDescending) {
        return (NSComparisonResult)NSOrderedDescending;
      } else {
        return NSOrderedSame;
      }
      
    } else if (![weakSelf isDirectoryAtPath:pathObj1] && [weakSelf isDirectoryAtPath:pathObj2]) {
      return NSOrderedDescending;
    } else if ([weakSelf isDirectoryAtPath:pathObj1] && ![weakSelf isDirectoryAtPath:pathObj2]) {
      return NSOrderedAscending;
    } else if (![weakSelf isDirectoryAtPath:pathObj1] && ![weakSelf isDirectoryAtPath:pathObj2]) {
      
      if ([obj1 compare:obj2] == NSOrderedAscending) {
        return (NSComparisonResult)NSOrderedAscending;
      } else if ([obj1 compare:obj2] == NSOrderedDescending) {
        return (NSComparisonResult)NSOrderedDescending;
      } else {
        return NSOrderedSame;
      }
    }
    return NSOrderedSame;
  }];
}

- (NSArray *)showHiddenFiles:(BOOL)show {
  NSMutableArray *newContents = [NSMutableArray array];
  NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:nil];
  if (!show) {
    for (NSString *fileName in contents) {
      NSString *firstChar = [fileName substringToIndex:1];
      if (![firstChar isEqualToString:@"."]) {
        [newContents addObject:fileName];
      }
    }
  }
  return newContents;
}

- (unsigned long long)folderSizeAtPath:(NSString *)folderPath {
  unsigned long long folderSize = 0;
  NSArray *content = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
  for (NSString *fileName in content) {
    NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
    if ([self isDirectoryAtPath:filePath]) {
      folderSize += [self folderSizeAtPath:filePath];
    } else {
      NSError *error = nil;
      NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];
      if (error) {
        NSLog(@"%@", [error localizedDescription]);
      }
      folderSize += [attributes fileSize];
    }
  }
  return folderSize;
}

- (void)addRefresh {
  UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
  [refresh addTarget:self action:@selector(refreshContents) forControlEvents:UIControlEventValueChanged];
  self.refreshControl = refresh;
}

#pragma mark - Action

- (IBAction)actionBackToRoot:(UIBarButtonItem *)sender {
  [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)actionEdit:(UIBarButtonItem *)sender {
  [self changeBarButtonItem];
}

- (IBAction)actionAddDirectory:(UIBarButtonItem *)sender {
  NSString *alertTitle = @"Create Folder";
  NSString *message = @"Enter the folder name";
  UIAlertController *ac = [UIAlertController alertControllerWithTitle:alertTitle message:message preferredStyle:UIAlertControllerStyleAlert];
  [ac addTextFieldWithConfigurationHandler:nil];
  
  __weak DirectoryTableViewController *weakSelf = self;
  UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    NSString *name = [ac.textFields[0] text];
    NSString *path = [weakSelf.path stringByAppendingPathComponent:name];
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    [weakSelf updateContents];
    [weakSelf sortContents];
    
    NSInteger row = [weakSelf.contents indexOfObject:name];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [weakSelf.tableView beginUpdates];
    [weakSelf.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [weakSelf.tableView endUpdates];
  }];
  UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
  
  [ac addAction:ok];
  [ac addAction:cancel];
  
  [self presentViewController:ac animated:YES completion:nil];
}

- (IBAction)actionRefresh:(UIBarButtonItem *)sender {
  [self refreshContents];
}

- (IBAction)actionFolderOptions:(UIBarButtonItem *)sender {
  FolderOptionsTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FolderOptionsTableViewController"];
  vc.directoryController = self;
  vc.showHiddenFiles = self.showHiddenFiles;
  vc.showFolderSize = self.showFolderSize;
  [self showDetailViewController:vc sender:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *fileIdentifier = @"fileCell";
  static NSString *folderCellWithSizeIdentifier = @"folderCellWithSize";
  static NSString *folderCellWithoutSize = @"folderCellWithoutSize";
  
  NSString *fileName = self.contents[indexPath.row];
  NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
  
  if ([self isDirectoryAtIndexPath:indexPath]) {
    if (self.showFolderSize) {
      FolderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:folderCellWithSizeIdentifier];
      cell.nameLabel.text = fileName;
      cell.sizeLabel.text = @"...";
      __block NSString *sizeLabel = nil;

      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sizeLabel = [NSByteCountFormatter stringFromByteCount:[self folderSizeAtPath:filePath] countStyle:NSByteCountFormatterCountStyleFile];
        dispatch_async(dispatch_get_main_queue(), ^{
          cell.sizeLabel.text = sizeLabel;
        });
      });
      
      return cell;
      
    } else {
      
      FolderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:folderCellWithoutSize];
      cell.nameLabel.text = fileName;
      return cell;
    }
    
  } else {

    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];

    FileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fileIdentifier];
    cell.nameLabel.text = fileName;
    cell.sizeLabel.text = [NSByteCountFormatter stringFromByteCount:[attributes fileSize] countStyle:NSByteCountFormatterCountStyleFile];
    return cell;
  }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *fileName = self.contents[indexPath.row];
    NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
    if ([fm isDeletableFileAtPath:filePath]) {
      [fm removeItemAtPath:filePath error:nil];
      [self updateContents];
      [self sortContents];
      
      [self.tableView beginUpdates];
      [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
      [self.tableView endUpdates];
    }
  }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  if ([self isDirectoryAtIndexPath:indexPath]) {
    NSString *fileName = self.contents[indexPath.row];
    NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
    DirectoryTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DirectoryTableViewController"];
    vc.path = filePath;
    vc.showHiddenFiles = self.showHiddenFiles;
    [self.navigationController pushViewController:vc animated:YES];
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 50.f;
}

#pragma mark - NSUserDefaults

- (void)saveSettings {
  NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
  [userDefault setBool:self.showHiddenFiles forKey:kShowHiddenFiles];
  [userDefault setBool:self.showFolderSize forKey:kShowFolderSize];
}

- (void)loadSettings {
  NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
  self.showHiddenFiles = [userDefault boolForKey:kShowHiddenFiles];
  self.showFolderSize = [userDefault boolForKey:kShowFolderSize];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
  [self refreshContents];
}

@end
