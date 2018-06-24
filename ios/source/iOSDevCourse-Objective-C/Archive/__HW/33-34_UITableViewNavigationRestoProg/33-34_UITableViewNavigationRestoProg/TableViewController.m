//
//  TableViewController.m
//  33-34_UITableViewNavigationRestoProg
//
//  Created by Oleg Tverdokhleb on 08.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "TableViewController.h"

#import "MRQFileCell.h"

@interface TableViewController ()

@property (strong, nonatomic) NSArray *contents;

@end

@implementation TableViewController

#pragma mark LifeCycle

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

#pragma mark - Setup

- (void) setup {
    
    //set default path
    if (!self.path) {
        self.path = @"/";
    }
}

- (void) setPath:(NSString *)path {
    
    _path = path;
    self.contents = [self initialTableContent];
    
    self.navigationItem.title = [self.path lastPathComponent];
    [self.tableView reloadData];
}

- (id) initWithPath:(NSString *) path {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.path = path;
    }
    return self;
}

- (NSArray *) initialTableContent {

    NSArray *contentArray = [NSArray array];
    NSArray *resultArray = [NSArray array];
    NSMutableArray *tempArray = [NSMutableArray array];
    
    NSError *error = nil;
    contentArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path
                                                                       error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    for (NSString *string in contentArray) {
        if (![string rangeOfString:@"."].location == 0) {
            [tempArray addObject:string];
        }
    }
    
    resultArray = [tempArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        if ([self isFile:obj1] && [self isFile:obj2]) {
            return [obj1 compare:obj2];
        } else if ([self isFile:obj1] && ![self isFile:obj2]) {
            return NSOrderedDescending;
        } else {
            return ![obj1 compare:obj2];
        }
    }];
    
    return resultArray;
}


- (void) initialNavigationControllerBarButtonItems {
    [self initialBackToRootBarButton];
}

- (void) initialBackToRootBarButton {
    UIBarButtonItem *backToRoot = [[UIBarButtonItem alloc] initWithTitle:@"to root"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(actionRootBarButtonWasPressed:)];
    [self.navigationItem setLeftBarButtonItem:backToRoot animated:YES];
}

#pragma mark - Actions

- (IBAction)actionEditBarButtonPressed:(UIBarButtonItem *)sender {
    BOOL isEditing = self.tableView.isEditing;
    if (isEditing) {
        [self createInsertFolderBarButton:NO];
        [self createDoneBarButtonTitle:NO];
    } else {
        [self createInsertFolderBarButton:YES];
        [self createDoneBarButtonTitle:YES];
    }
    [self.tableView setEditing:!isEditing animated:YES];
}

- (void) actionRootBarButtonWasPressed:(UIBarButtonItem *) sender {
    self.path = @"/";
}

- (void) actionInsertBarButtonWasPressed:(UIBarButtonItem *) sender {
    [self createFolderWithName:@"NeedAlert"];
}

#pragma mark - Additional

- (BOOL) isDirectoryAtIndexPath:(NSIndexPath *) indexPath {
    BOOL isDirectory = NO;
    NSString *fileName = [self.contents objectAtIndex:indexPath.row];
    NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    return isDirectory;
}

- (void) createInsertFolderBarButton:(BOOL) create {
    if (create) {
        UIBarButtonItem *insertBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                             target:self
                                                                                             action:@selector(actionInsertBarButtonWasPressed:)];
        [self.navigationItem setLeftBarButtonItem:insertBarButtonItem];
    } else {
        [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    }
}

- (void) createDoneBarButtonTitle:(BOOL) create {
    if (create) {
        UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(actionEditBarButtonPressed:)];
        [self.navigationItem setRightBarButtonItem:doneBarButtonItem animated:YES];
    } else {
        [self.navigationItem setRightBarButtonItem:self.editBarButtonItem animated:YES];
    }
}

- (void) createFolderWithName:(NSString *) name {
    if (name != nil) {
        BOOL isFolder;
        NSError *error = nil;
        NSString *filePath = [self.path stringByAppendingPathComponent:name];
        NSFileManager *fileManager = [NSFileManager defaultManager];

        if (![fileManager fileExistsAtPath:filePath isDirectory:&isFolder]) {
            if (![fileManager createDirectoryAtPath:filePath
                        withIntermediateDirectories:YES
                                         attributes:nil
                                              error:&error]) {
                NSLog(@"Create folder error: %@", filePath);
            }
        }
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.contents];
        [tempArray insertObject:name atIndex:0];
        self.contents = tempArray;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];

        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}

- (void) deleteFolder:(NSString *) path atIndexPath:(NSIndexPath *) indexPath {
    NSError *error = nil;
    NSString *filePath = [self.path stringByAppendingPathComponent:path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.contents];
    [tempArray removeObjectAtIndex:indexPath.row];
    self.contents = tempArray;
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView endUpdates];
}

- (BOOL) isFile:(id) obj {
    
    BOOL isFile = NO;
    NSString *filePath = [self.path stringByAppendingPathComponent:obj];
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isFile];
    return !isFile;
}

- (unsigned long long) sizeOfFolderAtPath:(NSString *) path {
    
    unsigned long long result = 0;
    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString *itemName in array) {
        BOOL isDirectory = NO;
        NSString *itemPath = [path stringByAppendingPathComponent:itemName];
        [[NSFileManager defaultManager] fileExistsAtPath:itemPath isDirectory:&isDirectory];
        
        if (!isDirectory) {
            NSFileManager *fm = [NSFileManager defaultManager];
            NSDictionary *attributes = [fm attributesOfItemAtPath:itemPath error:nil];
            result += [[attributes objectForKey:NSFileSize] unsignedIntegerValue];
        } else {
            result += [self sizeOfFolderAtPath:itemPath];
        }
    }
    
    return result;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self isDirectoryAtIndexPath:indexPath]) {
        
        UITableViewCell *folderCell = [tableView dequeueReusableCellWithIdentifier:@"folderCell"];
        
        NSString *path = [self.contents objectAtIndex:indexPath.row];
        NSString *folderPath = [self.path stringByAppendingPathComponent:path];
        
        NSString *folderSize = [NSByteCountFormatter stringFromByteCount:[self sizeOfFolderAtPath:folderPath] countStyle:NSByteCountFormatterCountStyleFile];
        
        folderCell.textLabel.text = [self.contents objectAtIndex:indexPath.row];
        folderCell.detailTextLabel.text = folderSize;
        
        return folderCell;
        
    } else {
        
        NSString *itemName = [self.contents objectAtIndex:indexPath.row];
        NSString *itemPath = [self.path stringByAppendingPathComponent:itemName];
        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:itemPath error:nil];

        
        MRQFileCell *fileCell = [tableView dequeueReusableCellWithIdentifier:@"fileCell"];
        fileCell.nameLabel.text = [self.contents objectAtIndex:indexPath.row];
        
        static NSDateFormatter *dateFormatter = nil;
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
        }
        
        fileCell.dateLabel.text = [dateFormatter stringFromDate:[attributes fileModificationDate]];
        
        fileCell.sizeLabel.text = [NSByteCountFormatter stringFromByteCount:[attributes fileSize] countStyle:NSByteCountFormatterCountStyleFile];
        return fileCell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *fileName = [self.contents objectAtIndex:indexPath.row];
        [self deleteFolder:fileName atIndexPath:indexPath];
    }
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
        NSString *fileName = [self.contents objectAtIndex:indexPath.row];
        NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
        TableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
        vc.path = filePath;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - NSFileManagerDelegate

- (BOOL)fileManager:(NSFileManager *)fileManager shouldRemoveItemAtPath:(NSString *)path {
    return YES;
}

@end
