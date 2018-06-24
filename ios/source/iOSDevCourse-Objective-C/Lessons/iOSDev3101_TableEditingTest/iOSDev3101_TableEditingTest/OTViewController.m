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
  
  //table view initial
  CGRect frame = self.view.bounds;
  frame.origin = CGPointZero;
  UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
  tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  tableView.delegate = self;
  tableView.dataSource = self;
  [self.view addSubview:tableView];
  self.tableView = tableView;
  tableView.editing = YES;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  
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

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[self.groups[section] students] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.groups count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return [NSString stringWithFormat:@"%@", [self.groups[section] name]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
  }
  
  OTGroup *group = self.groups[indexPath.section];
  OTStudent *student = group.students[indexPath.row];
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
  return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
  //source
  OTGroup *sourceGroup = self.groups[sourceIndexPath.section];
  OTStudent *student = sourceGroup.students[sourceIndexPath.row];
  
  //destination
  OTGroup *destinationGroup = self.groups[destinationIndexPath.section];
  
  //temp
  NSMutableArray *tempArray = [NSMutableArray arrayWithArray:sourceGroup.students];

  //check for equals sections(groups)
  if (sourceIndexPath.section == destinationIndexPath.section) {
  
    [tempArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    sourceGroup.students = tempArray;
  
  } else {
    
    //remove object from source array
    [tempArray removeObject:student];
    sourceGroup.students = tempArray;
    
    //add object to destionation array
    tempArray = [NSMutableArray arrayWithArray:destinationGroup.students];
    [tempArray insertObject:student atIndex:destinationIndexPath.row];
    destinationGroup.students = tempArray;
  }
}

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  return UITableViewCellEditingStyleNone;
}

@end
