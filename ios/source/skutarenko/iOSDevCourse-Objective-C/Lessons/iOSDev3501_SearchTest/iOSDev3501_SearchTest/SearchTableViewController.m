//
//  SearchTableViewController.m
//  iOSDev3501_SearchTest
//
//  Created by Oleg Tverdokhleb on 01.05.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "SearchTableViewController.h"
#import "OTGroup.h"
#import "OTStudent.h"
#import "Section.h"

@interface SearchTableViewController ()
@property (strong, nonatomic) NSArray *content;
@end

@implementation SearchTableViewController

#pragma mark - View lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  self.content = [OTGroup initWithDefaultGroups];
  self.content = [self sortAlphabetically:self.content];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  NSLog(@"didReceiveMemoryWarning");
}

#pragma mark - Additional

- (NSArray *)sortAlphabetically:(NSArray *)content {
  NSMutableArray *groups = [NSMutableArray arrayWithArray:content];
  NSMutableArray *allStudents = [NSMutableArray array];
  NSMutableArray *sections = [NSMutableArray array];
  
  //take all students
  for (OTGroup *group in groups) {
    for (OTStudent *student in group.students) {
      [allStudents addObject:student];
    }
  }
  
  NSSortDescriptor *nameDescr = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
  [allStudents sortUsingDescriptors:@[nameDescr]];
  
  NSString *currentLetter = nil;
  Section *section = nil;
  for (OTStudent *student in allStudents) {
    NSString *firstLetter = [student.name substringToIndex:1];
    if (![currentLetter isEqualToString:firstLetter]) {
      currentLetter = firstLetter;
      section = [[Section alloc] init];
      section.name = firstLetter;
      section.items = [NSMutableArray array];
      [sections addObject:section];
    } else {
      section = [sections lastObject];
    }
    [section.items addObject:student];
  }
  
  return sections;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.content count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[self.content[section] items] count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return [self.content[section] name];
}

//- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//  return [NSString stringWithFormat:@"%ld students in group", [self.content[section] count]];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
  }
  
  Section *group = self.content[indexPath.section];
  OTStudent *student = group.items[indexPath.row];
  
  cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.name, student.lastname];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f", student.averageScore];
  
  return cell;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
  NSMutableArray *names = [NSMutableArray array];
  for (Section *section in self.content) {
    [names addObject:section.name];
  }
  return names;
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
  
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
  [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
  searchBar.text = nil;
  [searchBar resignFirstResponder];
  [searchBar setShowsCancelButton:NO animated:YES];
}

@end
