//
//  DirectoryTableViewController.m
//  iOSDev3301_FileManagerTest
//
//  Created by Oleg Tverdokhleb on 29.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "DirectoryTableViewController.h"

@interface DirectoryTableViewController ()

@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSArray *contents;

@end

@implementation DirectoryTableViewController

#pragma mark - View lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = [self.path lastPathComponent];
  
  if ([self.navigationController.viewControllers count] > 1) {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                          target:self
                                                                          action:@selector(actionBackToRoot:)];
    self.navigationItem.rightBarButtonItem = item;
    
  }
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  NSLog(@"%@", self.path);
  NSLog(@"view contollers on stack = %ld", [self.navigationController.viewControllers count]);
  NSLog(@"index on stack %ld", [self.navigationController.viewControllers indexOfObject:self]);
}

- (void)dealloc {
  NSLog(@"controller with path %@ has been deallocated", self.path);
}

#pragma mark - Initialization

- (instancetype)initWithFolderPath:(NSString *)path {
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    self.path = path;
    NSError *error = nil;
    self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path error:&error];
    if (error) {
      NSLog(@"%@", [error localizedDescription]);
    }
  }
  return self;
}

#pragma mark - Action

- (void)actionBackToRoot:(UIBarButtonItem *)sender {
  [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Additional

- (BOOL)isDirectoryAtIndexPath:(NSIndexPath *)indexPath {
  NSString *fileName = self.contents[indexPath.row];
  BOOL isDirectory = NO;
  NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
  [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
  return isDirectory;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  NSString *fileName = self.contents[indexPath.row];
  cell.textLabel.text = fileName;
  
  if ([self isDirectoryAtIndexPath:indexPath]) {
    cell.imageView.image = [UIImage imageNamed:@"folder"];
  } else {
    cell.imageView.image = [UIImage imageNamed:@"file"];
  }
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  if ([self isDirectoryAtIndexPath:indexPath]) {
    
    NSString *fileName = self.contents[indexPath.row];
    NSString *path = [self.path stringByAppendingPathComponent:fileName];
    
    DirectoryTableViewController *vc = [[DirectoryTableViewController alloc] initWithFolderPath:path];
    [self.navigationController pushViewController:vc animated:YES];
  }
}

@end

















