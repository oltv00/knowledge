//
//  MRQDirectoryTableViewController.m
//  33_FileManagerTest
//
//  Created by Oleg Tverdokhleb on 06.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQDirectoryTableViewController.h"

@interface MRQDirectoryTableViewController ()

@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSArray *contents;

@end

@implementation MRQDirectoryTableViewController

#pragma mark - LifeCycle

- (void) loadView {
    [super loadView];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"path = %@", self.path);
    NSLog(@"view controllers on stack = %ld", [self.navigationController.viewControllers count]);
    NSLog(@"index on stack = %ld", [self.navigationController.viewControllers indexOfObject:self]);
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void) dealloc {
    
    NSLog(@"controller with path %@ has been deallocated", self.path);
}

#pragma mark - Initial methods

- (id) initWithFolderPath:(NSString *) path {
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.path = path;
        
        NSError *error = nil;
        self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path
                                                                            error:&error];
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
    return self;
}

- (void) setup {
    [self navigationControllerSetup];
}

- (void) navigationControllerSetup {
    
    self.navigationItem.title = [self.path lastPathComponent];
    [self navigationControllerRootButtonSetup];
}

- (void) navigationControllerRootButtonSetup {
    
    if ([self.navigationController.viewControllers count] > 1) {
        UIBarButtonItem *rootButton = [[UIBarButtonItem alloc] initWithTitle:@"back to root"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(actionRootBarButtonPressed:)];
        
        [self.navigationItem setRightBarButtonItem:rootButton animated:YES];
    }
}

#pragma mark - Additional methods

- (BOOL) isDirectoryAtIndexPath:(NSIndexPath *) indexPath {
    
    BOOL isDirectory = NO;
    
    NSString *fileName = [self.contents objectAtIndex:indexPath.row];
    NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
    
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    return isDirectory;
}

#pragma mark - Actions

- (void) actionRootBarButtonPressed:(UIBarButtonItem *) sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.contents objectAtIndex:indexPath.row];
    
    if ([self isDirectoryAtIndexPath:indexPath]) {
        cell.imageView.image = [UIImage imageNamed:@"folder.png"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"file.png"];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self isDirectoryAtIndexPath:indexPath]) {
        
        NSString *curretPath = [self.contents objectAtIndex:indexPath.row];
        NSString *selectPath = [self.path stringByAppendingPathComponent:curretPath];
        MRQDirectoryTableViewController *vc = [[MRQDirectoryTableViewController alloc] initWithFolderPath:selectPath];

        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
