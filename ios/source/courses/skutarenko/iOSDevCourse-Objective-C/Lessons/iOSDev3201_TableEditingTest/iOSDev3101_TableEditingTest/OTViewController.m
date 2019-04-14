//
//  OTViewController.m
//  iOSDev3101_TableEditingTest
//
//  Created by Oleg Tverdokhleb on 25.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTViewController.h"
#import "OTGroup.h"
#import "OTStudent.h"

@interface OTViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *groups;

@end

@implementation OTViewController

#pragma mark - View lifecycles
- (void)loadView {
  [super loadView];
  [self tableViewSetup];
}

- (void)viewDidLoad {
  [super viewDidLoad];
//  [self tableViewInitWithContent];
  self.groups = [NSMutableArray array];
  [self navigationBarSetup];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)tableViewSetup {
  //table view initial
  CGRect frame = self.view.bounds;
  frame.origin = CGPointZero;
  UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
  tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  tableView.delegate = self;
  tableView.dataSource = self;
  [self.view addSubview:tableView];
  self.tableView = tableView;
  
  //Возможность нажать на ячейки в режиме редактирования
  self.tableView.allowsSelectionDuringEditing = YES;
}

- (void)tableViewInitWithContent {
  self.groups = [NSMutableArray array];
  
  for (int i = 0; i < 5 + arc4random_uniform(6); i += 1) {
    OTGroup *group = [[OTGroup alloc] init];
    group.name = [NSString stringWithFormat:@"Group #%d", i];
    
    NSMutableArray *students = [NSMutableArray array];
    for (int j = 0; j < 15 + arc4random_uniform(11); j += 1) {
      OTStudent *student = [OTStudent randomStudent];
      [students addObject:student];
    }
    group.students = students;
    [self.groups addObject:group];
  }
  [self.tableView reloadData];
}

- (void)navigationBarSetup {
  self.navigationItem.title = @"Students";
  
  UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                        target:self
                                                                        action:@selector(actionEdit:)];
  self.navigationItem.rightBarButtonItem = edit;
  
  UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                       target:self
                                                                       action:@selector(actionAddSection:)];
  self.navigationItem.leftBarButtonItem = add;
  
}
#pragma mark - Action
- (void)actionEdit:(UIBarButtonItem *)sender {
  BOOL isEditing = self.tableView.editing;
  [self.tableView setEditing:!isEditing animated:YES];
  
  UIBarButtonSystemItem item = UIBarButtonSystemItemEdit;
  
  if (self.tableView.editing) {
    item = UIBarButtonSystemItemDone;
  }
  
  UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item
                                                                        target:self
                                                                        action:@selector(actionEdit:)];
  [self.navigationItem setRightBarButtonItem:edit animated:YES];
}

- (void)actionAddSection:(UIBarButtonItem *)sender {
  OTGroup *group = [[OTGroup alloc] init];
  group.name = [NSString stringWithFormat:@"Group #%ld", [self.groups count] + 1];
  group.students = @[[OTStudent randomStudent], [OTStudent randomStudent]];
  [self.groups insertObject:group atIndex:0];
  
  NSInteger newSectionIndex = 0;
  
  UITableViewRowAnimation animation = UITableViewRowAnimationFade;
  
  [self.tableView beginUpdates];
  
  NSIndexSet *insertSections = [NSIndexSet indexSetWithIndex:newSectionIndex];
  
  if ([self.groups count] > 1) {
    animation = [self.groups count] % 2 ? UITableViewRowAnimationLeft : UITableViewRowAnimationRight;
  }
  
  [self.tableView insertSections:insertSections withRowAnimation:animation];
  
  [self.tableView endUpdates];
  
  [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
      [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }
  });
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[self.groups[section] students] count] + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.groups count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return [NSString stringWithFormat:@"%@", [self.groups[section] name]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *addStudentIdentifier = @"AddCell";
  
  if (indexPath.row == 0) {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addStudentIdentifier];
    
    if (!cell) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addStudentIdentifier];
      cell.textLabel.textColor = [UIColor blueColor];
      cell.textLabel.text = @"Tap to add new student";
    }
    return cell;
  }
  
  static NSString *studentIdentifier = @"StudentCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:studentIdentifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:studentIdentifier];
  }
  
  OTGroup *group = self.groups[indexPath.section];
  OTStudent *student = group.students[indexPath.row - 1];
  cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.name, student.lastname];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", student.averageGrade];
  
  if (student.averageGrade >= 4.0) {
    cell.detailTextLabel.textColor = [UIColor greenColor];
  } else if (student.averageGrade > 3) {
    cell.detailTextLabel.textColor = [UIColor orangeColor];
  } else {
    cell.detailTextLabel.textColor = [UIColor redColor];
  }
  
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  return indexPath.row > 0;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
  //source
  OTGroup *sourceGroup = self.groups[sourceIndexPath.section];
  OTStudent *student = sourceGroup.students[sourceIndexPath.row - 1];
  
  //destination
  OTGroup *destinationGroup = self.groups[destinationIndexPath.section];
  
  //temp
  NSMutableArray *tempArray = [NSMutableArray arrayWithArray:sourceGroup.students];
  
  //check for equals sections(groups)
  if (sourceIndexPath.section == destinationIndexPath.section) {
    
    [tempArray exchangeObjectAtIndex:sourceIndexPath.row - 1 withObjectAtIndex:destinationIndexPath.row - 1];
    sourceGroup.students = tempArray;
    
  } else {
    
    //remove object from source array
    [tempArray removeObject:student];
    sourceGroup.students = tempArray;
    
    //add object to destionation array
    tempArray = [NSMutableArray arrayWithArray:destinationGroup.students];
    [tempArray insertObject:student atIndex:destinationIndexPath.row - 1];
    destinationGroup.students = tempArray;
  }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    OTGroup *group = self.groups[indexPath.section];
    OTStudent *student = group.students[indexPath.row - 1];
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:group.students];
    [tempArray removeObject:student];
    group.students = tempArray;
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    [self.tableView endUpdates];
    
    
  }
}

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  return indexPath.row == 0 ? UITableViewCellEditingStyleNone : UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
  if (proposedDestinationIndexPath.row == 0) {
    return sourceIndexPath;
  } else {
    return proposedDestinationIndexPath;
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  if (indexPath.row == 0) {
    OTGroup *group = self.groups[indexPath.section];
    NSMutableArray *tempArray = nil;
    if (group.students) {
      tempArray = [NSMutableArray arrayWithArray:group.students];
    } else {
      tempArray = [NSMutableArray array];
    }
    NSInteger newStudentIndex = 0;
    [tempArray insertObject:[OTStudent randomStudent] atIndex:newStudentIndex];
    group.students = tempArray;
    
    [self.tableView beginUpdates];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:newStudentIndex + 1 inSection:indexPath.section];
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView endUpdates];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
      }
    });
  }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
  return @"Remove";
}

@end
