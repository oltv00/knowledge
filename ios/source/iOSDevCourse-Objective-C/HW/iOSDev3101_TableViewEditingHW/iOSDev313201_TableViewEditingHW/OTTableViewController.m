//
//  OTTableViewController.m
//  iOSDev313201_TableViewEditingHW
//
//  Created by Oleg Tverdokhleb on 26.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTTableViewController.h"
#import "OTGroup.h"
#import "OTStudent.h"

typedef NS_ENUM(NSInteger, BarButtonSide) {
  BarButtonSideLeft,
  BarButtonSideRight
};

typedef NS_ENUM(NSInteger, AddStudentMode) {
  AddStudentModeON,
  AddStudentModeOFF
};

@interface OTTableViewController ()
@property (strong, nonatomic) NSArray *groups;
@end

@implementation OTTableViewController

#pragma mark - View lifecycles

- (void)loadView {
  [super loadView];
  [self tableViewSetup];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  /*
   *Uncomment for first initialization
   *
   *[self initTableViewWithContent];
   */
  
  [self initBarButtons];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Setups

- (void)tableViewSetup {
  CGRect frame = self.view.bounds;
  UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
  tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  tableView.allowsSelectionDuringEditing = YES;
  tableView.delegate = self;
  tableView.dataSource = self;
  [self.view addSubview:tableView];
  self.tableView = tableView;
}

- (void)initTableViewWithContent {
  self.groups = [OTGroup initWithDefaultGroups];
}

- (void)initBarButtons {
  [self initEditBarButton];
  [self initAddSectionBarButton];
}

- (void)initEditBarButton {
  [self initBarButtonSystemItemWithStyle:UIBarButtonSystemItemEdit action:@selector(actionEdit:) side:BarButtonSideRight];
}

- (void)initDoneBarButton {
  [self initBarButtonSystemItemWithStyle:UIBarButtonSystemItemDone action:@selector(actionEdit:) side:BarButtonSideRight];
}

- (void)initAddSectionBarButton {
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionAddSection:)];
  [self.navigationItem setLeftBarButtonItem:item animated:YES];
}

#pragma mark - Additional

- (void)paintDetailCell:(UITableViewCell *)cell onAverageScore:(double)score {
  if (score > 4.8f) {
    cell.detailTextLabel.textColor = [UIColor greenColor];
  } else if (score > 3) {
    cell.detailTextLabel.textColor = [UIColor orangeColor];
  } else {
    cell.detailTextLabel.textColor = [UIColor redColor];
  }
}

- (void)initBarButtonSystemItemWithStyle:(UIBarButtonSystemItem)style action:(SEL)selector side:(BarButtonSide)side {
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:style target:self action:selector];
  if (side == BarButtonSideRight) {
    [self.navigationItem setRightBarButtonItem:item animated:YES];
  } else {
    [self.navigationItem setLeftBarButtonItem:item animated:YES];
  }
}

- (void)addRowToAddNewStudents:(AddStudentMode)mode {
  NSUInteger allSections = [self.groups count];
  
  
  for (int section = 0; section < allSections; section += 1) {
    OTGroup *group = self.groups[section];
    id empty = [[NSObject alloc] init];
    NSMutableArray *students = [NSMutableArray arrayWithArray:group.students];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    
    if (mode == AddStudentModeON) {
      [students insertObject:empty atIndex:0];
      group.students = students;
      [self.tableView beginUpdates];
      [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
      [self.tableView endUpdates];
    } else {
      if (students.count > 0) {
        [students removeObjectAtIndex:0];
        group.students = students;
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
      }
    }
  }
}

- (void)addNewStudentWithIndexPath:(NSIndexPath *)indexPath {
  OTGroup *group = self.groups[indexPath.section];
  NSMutableArray *students = nil;
  
  if (group.students) {
    students = [NSMutableArray arrayWithArray:group.students];
  } else {
    students = [NSMutableArray array];
  }
  OTStudent *student = [OTStudent initRandomStudent];
  [students insertObject:student atIndex:1];
  group.students = students;
  group.count += 1;
  
  NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
  [self.tableView beginUpdates];
  [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationRight];
  [self.tableView footerViewForSection:indexPath.section].textLabel.text = [NSString stringWithFormat:@"In the group %ld students", group.count];
  [self.tableView endUpdates];
}

- (void)ignoringInteractionEvents {
  [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
      [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }
  });
}

#pragma mark - Actions

- (void)actionEdit:(UIBarButtonItem *)sender {
  BOOL isEditing = self.tableView.editing;
  [self.tableView setEditing:!isEditing animated:YES];
  
  if (isEditing) {
    [self initEditBarButton];
    [self addRowToAddNewStudents:AddStudentModeOFF];
  } else {
    [self addRowToAddNewStudents:AddStudentModeON];
    [self initDoneBarButton];
  }
  [self ignoringInteractionEvents];
}

- (void)actionAddSection:(UIBarButtonItem *)sender {
  NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.groups];
  NSString *groupName = [NSString stringWithFormat:@"Group #%ld", [self.groups count] + 1];
  OTGroup *group = [[OTGroup alloc] initGroupWithName:groupName studentsCount:0];
  [tempArray insertObject:group atIndex:0];
  self.groups = tempArray;
  
  [self.tableView beginUpdates];
  NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
  [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationTop];
  [self.tableView endUpdates];
  [self ignoringInteractionEvents];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.groups count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return [self.groups[section] name];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
  OTGroup *group = self.groups[section];
  return [NSString stringWithFormat:@"In the group %ld students", group.count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[self.groups[section] students] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *studentIdentifier = @"studentCell";
  static NSString *addStudentIndetifier = @"addStudentCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:studentIdentifier];
  UITableViewCell *addCell = [tableView dequeueReusableCellWithIdentifier:addStudentIndetifier];
  
  if (self.tableView.editing && indexPath.row == 0) {
    if (!addCell) {
      addCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addStudentIndetifier];
    }
    addCell.textLabel.text = @"Tap to add new student";
    addCell.textLabel.textAlignment = NSTextAlignmentCenter;
    addCell.textLabel.textColor = [UIColor blueColor];
    return addCell;
  } else {
    if (!cell) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:studentIdentifier];
    }
    OTGroup *group = self.groups[indexPath.section];
    OTStudent *student = group.students[indexPath.row];
    if ([student isKindOfClass:[OTStudent class]]) {
      [self paintDetailCell:cell onAverageScore:student.averageScore];
      cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.name, student.lastname];
      cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f", student.averageScore];
    }
    return cell;
  }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  return indexPath.row > 0;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
  OTGroup *sourceGroup = self.groups[sourceIndexPath.section];
  OTGroup *destinationGroup = self.groups[destinationIndexPath.section];
  OTStudent *student = sourceGroup.students[sourceIndexPath.row];
  NSMutableArray *tempArray = [NSMutableArray arrayWithArray:sourceGroup.students];
  
  if (sourceIndexPath.section == destinationIndexPath.section) {
    [tempArray removeObjectAtIndex:sourceIndexPath.row];
    [tempArray insertObject:student atIndex:destinationIndexPath.row];
    destinationGroup.students = tempArray;
  } else {
    //source update
    [tempArray removeObject:student];
    sourceGroup.students = tempArray;
    
    //destination update
    tempArray = [NSMutableArray arrayWithArray:destinationGroup.students];
    [tempArray insertObject:student atIndex:destinationIndexPath.row];
    destinationGroup.students = tempArray;
  }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    OTGroup *group = self.groups[indexPath.section];
    OTStudent *student = group.students[indexPath.row];
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:group.students];
    [tempArray removeObject:student];
    group.students = tempArray;
    group.count -= 1;
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView footerViewForSection:indexPath.section].textLabel.text = [NSString stringWithFormat:@"In the group %ld students", group.count];
    [self.tableView endUpdates];
    
  } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    [self addNewStudentWithIndexPath:indexPath];
    [self ignoringInteractionEvents];
  }
}

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    return UITableViewCellEditingStyleNone;
  } else {
    return UITableViewCellEditingStyleDelete;
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  if (indexPath.row == 0 && self.tableView.editing) {
    [self addNewStudentWithIndexPath:indexPath];
    [self ignoringInteractionEvents];
  }
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

@end