//
//  ASDirectoryViewController.m
//  FileManagerTest
//
//  Created by Oleksii Skutarenko on 26.12.13.
//  Copyright (c) 2013 Alex Skutarenko. All rights reserved.
//

#import "ASDirectoryViewController.h"
#import "ASFileCell.h"
#import "UIView+UITableViewCell.h"

@interface ASDirectoryViewController ()

@property (strong, nonatomic) NSArray* contents;

@property (strong, nonatomic) NSString* selectedPath;
@end


@implementation ASDirectoryViewController

- (id) initWithFolderPath:(NSString*) path
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        self.path = path;
    }
    
    return self;
}

- (void) setPath:(NSString *)path {
    
    _path = path;
    
    NSError* error = nil;
    
    self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path
                                                                        error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }

    [self.tableView reloadData];
    
    self.navigationItem.title = [self.path lastPathComponent];
}

- (void) dealloc {
    NSLog(@"controller with path %@ has been deallocated", self.path);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.path) {
        self.path = @"/Volumes/Media/Projects/iOSDevCourse";
    }
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if ([self.navigationController.viewControllers count] > 1) {
        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"Back to Root"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(actionBackToRoot:)];
        self.navigationItem.rightBarButtonItem = item;
    }
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    NSLog(@"path = %@", self.path);
    NSLog(@"view controllers on stack = %d", [self.navigationController.viewControllers count]);
    NSLog(@"index on stack %d", [self.navigationController.viewControllers indexOfObject:self]);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) isDirectoryAtIndexPath:(NSIndexPath*) indexPath {
    
    NSString* fileName = [self.contents objectAtIndex:indexPath.row];
    
    NSString* filePath = [self.path stringByAppendingPathComponent:fileName];
    
    BOOL isDirectory = NO;
    
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    return isDirectory;
}

#pragma mark - Actions

- (void) actionBackToRoot:(UIBarButtonItem*) sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction) actionInfoCell:(UIButton*)sender {
    
    NSLog(@"actionInfoCell");
    
    UITableViewCell* cell = [sender superCell];
    
    if (cell) {
        
        NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
        
        [[[UIAlertView alloc]
          initWithTitle:@"Yahoo!"
          message:[NSString stringWithFormat:@"action %d %d", indexPath.section, indexPath.row]
          delegate:nil
          cancelButtonTitle:@"OK"
          otherButtonTitles:nil] show];
        
        
    }
    
}

- (NSString*) fileSizeFromValue:(unsigned long long) size {
    
    static NSString* units[] = {@"B", @"KB", @"MB", @"GB", @"TB"};
    static int unitsCount = 5;
    
    int index = 0;
    
    double fileSize = (double)size;
    
    while (fileSize > 1024 && index < unitsCount) {
        fileSize /= 1024;
        index++;
    }
    
    return [NSString stringWithFormat:@"%.2f %@", fileSize, units[index]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *fileIdentifier = @"FileCell";
    static NSString *folderIdentifier = @"FolderCell";
    
    NSString* fileName = [self.contents objectAtIndex:indexPath.row];
    
    if ([self isDirectoryAtIndexPath:indexPath]) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:folderIdentifier];
        
        cell.textLabel.text = fileName;
        
        return cell;
        
    } else {
        
        NSString* path = [self.path stringByAppendingPathComponent:fileName];
        
        NSDictionary* attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        
        ASFileCell *cell = [tableView dequeueReusableCellWithIdentifier:fileIdentifier];
        
        cell.nameLabel.text = fileName;
        cell.sizeLabel.text = [self fileSizeFromValue:[attributes fileSize]];
        
        static NSDateFormatter* dateFormatter = nil;
        
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
        }
        
        cell.dateLabel.text = [dateFormatter stringFromDate:[attributes fileModificationDate]];
        
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self isDirectoryAtIndexPath:indexPath]) {
        return 44.f;
    } else {
        return 80.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self isDirectoryAtIndexPath:indexPath]) {
        
        NSString* fileName = [self.contents objectAtIndex:indexPath.row];
        
        NSString* path = [self.path stringByAppendingPathComponent:fileName];
        
        //ASDirectoryViewController* vc = [[ASDirectoryViewController alloc] initWithFolderPath:path];
        //[self.navigationController pushViewController:vc animated:YES];
        
        //ASDirectoryViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ASDirectoryViewController"];
        //vc.path = path;
        //[self.navigationController pushViewController:vc animated:YES];
        
        self.selectedPath = path;
        
        [self performSegueWithIdentifier:@"navigateDeep" sender:nil];
    }
    
}

#pragma mark - Segue

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    NSLog(@"shouldPerformSegueWithIdentifier: %@", identifier);
    
    return YES;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"prepareForSegue: %@", segue.identifier);
    
    ASDirectoryViewController* vc = segue.destinationViewController;
    vc.path = self.selectedPath;
}

@end
