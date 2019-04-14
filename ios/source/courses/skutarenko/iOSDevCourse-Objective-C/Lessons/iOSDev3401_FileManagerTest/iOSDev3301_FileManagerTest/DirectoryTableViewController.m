//
//  DirectoryTableViewController.m
//  iOSDev3301_FileManagerTest
//
//  Created by Oleg Tverdokhleb on 29.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "DirectoryTableViewController.h"
#import "FileTableViewCell.h"
#import "UIView+UITableViewCell.h"

@interface DirectoryTableViewController ()

@property (strong, nonatomic) NSArray *contents;

@end

@implementation DirectoryTableViewController

#pragma mark - View lifecycles

/*
 /Users/oltv00/Documents/Objective-C/IOSDevCourse
 */

- (void)viewDidLoad {
  [super viewDidLoad];
  
  if (!self.path) {
    self.path = @"/Users/oltv00/Documents/Objective-C/IOSDevCourse";
  }
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  NSLog(@"%@", self.path);
  NSLog(@"view contollers on stack = %ld", [self.navigationController.viewControllers count]);
  NSLog(@"index on stack %ld", [self.navigationController.viewControllers indexOfObject:self]);
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self addBackToRootButton];
}

- (void)dealloc {
  NSLog(@"controller with path %@ has been deallocated", self.path);
}

#pragma mark - Initialization

- (instancetype)initWithFolderPath:(NSString *)path {
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    self.path = path;
  }
  return self;
}

- (void)setPath:(NSString *)path {
  _path = path;
  NSError *error = nil;
  self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:&error];
  if (error) {
    NSLog(@"%@", [error localizedDescription]);
  }
  [self.tableView reloadData];
  self.navigationItem.title = [self.path lastPathComponent];
}

#pragma mark - Action

- (void)actionBackToRoot:(UIBarButtonItem *)sender {
  [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)actionInfoCell:(UIButton *)sender {
  NSLog(@"actionInfoCell");
  
  UITableViewCell *cell = [sender superCell];
  NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
  
  if (cell) {
    NSLog(@"tapped %ld %ld", indexPath.section, indexPath.row);
  }
}

#pragma mark - Additional

- (BOOL)isDirectoryAtIndexPath:(NSIndexPath *)indexPath {
  NSString *fileName = self.contents[indexPath.row];
  BOOL isDirectory = NO;
  NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
  [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
  return isDirectory;
}

- (void)addBackToRootButton {
  if ([self.navigationController.viewControllers count] > 1) {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(actionBackToRoot:)];
    self.navigationItem.rightBarButtonItem = item;
  }
}

- (NSString *)fileSizeFromValue:(unsigned long long)size {
  static NSString *units[] = {@"B", @"KB", @"MB", @"GB", @"TB"};
  static int unitCount = 5;
  
  int index = 0;
  double fileSize = (double)size;
  
  while (fileSize > 1024 && index < unitCount) {
    fileSize /= 1024;
    index += 1;
  }
  return [NSString stringWithFormat:@"%.2f %@", fileSize, units[index]];
}

- (NSString *)stringFromDate:(NSDate *)date {
  static NSDateFormatter *dateFormatter = nil;
  if (!dateFormatter) {
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm"];
  }
  return [dateFormatter stringFromDate:date];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *folderIdentifier = @"FolderCell";
  static NSString *fileIdentifier = @"FileCell";
  
  NSString *fileName = self.contents[indexPath.row];
  
  if ([self isDirectoryAtIndexPath:indexPath]) {
    
    //folder
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:folderIdentifier];
    cell.textLabel.text = fileName;
    return cell;
  
  } else {
    
    NSString *path = [self.path stringByAppendingPathComponent:fileName];
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    
    //file
    FileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fileIdentifier];
    
    cell.nameLabel.text = fileName;
    cell.sizeLabel.text = [self fileSizeFromValue:[attributes fileSize]];
    cell.dateLabel.text = [self stringFromDate:[attributes fileModificationDate]];
    
    return cell;
  }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  if ([self isDirectoryAtIndexPath:indexPath]) {
    
    NSString *fileName = self.contents[indexPath.row];
    NSString *path = [self.path stringByAppendingPathComponent:fileName];
    
    //Первый способ перехода
    //DirectoryTableViewController *vc = [[DirectoryTableViewController alloc] initWithFolderPath:path];
    //[self.navigationController pushViewController:vc animated:YES];
    
    //Второй способ перехода
    //DirectoryTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DirectoryTableViewController"];
    //vc.path = path;
    //[self.navigationController pushViewController:vc animated:YES];
    
    //Третий способ перехода
    [self performSegueWithIdentifier:@"navigateDeep" sender:path];
//    [self performSegueWithIdentifier:@"folderCellSegue" sender:path];
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (![self isDirectoryAtIndexPath:indexPath]) {
    return 80.f;
  }
  return 44;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSLog(@"prepareForSegue: %@", segue.identifier);
  
  DirectoryTableViewController *vc = segue.destinationViewController;
  vc.path = sender;
}

@end

















