//
//  SearchTableViewController.m
//  iOSDev3502_SearchTest
//
//  Created by Oleg Tverdokhleb on 01.05.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "SearchTableViewController.h"
#import "NSString+Random.h"
#import "AlphaSection.h"

@interface SearchTableViewController ()
@property (strong, nonatomic) NSArray *contentWithNames;
@property (strong, nonatomic) NSArray *contentWithSections;
@property (strong, nonatomic) NSOperationQueue *operationQueue;
@end

@implementation SearchTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  __weak SearchTableViewController *weakSelf = self;
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    weakSelf.contentWithNames = [weakSelf initializeByRandomStrings];
    weakSelf.contentWithNames = [weakSelf sortArrayAlphabetically:self.contentWithNames];
    [weakSelf sectionsFromArrayInBackground:weakSelf.contentWithNames withFilter:weakSelf.searchBar.text];
  });
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  NSLog(@"didReceiveMemoryWarning");
}

#pragma mark - Additional

- (NSArray *)initializeByRandomStrings {
  NSMutableArray *result = [NSMutableArray array];
  for (int i = 0; i < 1000000; i += 1) {
    [result addObject:[[NSString randomAlphanumericString] capitalizedString]];
  }
  return (NSArray *)result;
}

- (NSArray *)sortArrayAlphabetically:(NSArray *)array {
  NSMutableArray *mArray = [NSMutableArray arrayWithArray:array];
  
  NSSortDescriptor *sortBySelf = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
  [mArray sortUsingDescriptors:@[sortBySelf]];
  
  return mArray;
}

- (void)sectionsFromArrayInBackground:(NSArray *)array withFilter:(NSString *)filterString {
  [self.operationQueue cancelAllOperations];
  self.operationQueue = [[NSOperationQueue alloc] init];
  __weak SearchTableViewController *weakSelf = self;
  
  [self.operationQueue addOperationWithBlock:^{
    NSArray *sections = [weakSelf sectionsFromArray:array withFilter:filterString];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      weakSelf.contentWithSections = sections;
      [weakSelf.tableView reloadData];
    });
  }];
}

- (NSArray *)sectionsFromArray:(NSArray *)array withFilter:(NSString *)filterString {
  NSMutableArray *sections = [NSMutableArray array];
  NSString *currentLetter = nil;
  
  for (NSString *string in array) {
    AlphaSection *section = nil;
    NSString *firstLetter = [string substringToIndex:1];
    
    if ([filterString length] > 0 && [string rangeOfString:filterString].location == NSNotFound) {
      continue;
    }
    
    if (![currentLetter isEqualToString:firstLetter]) {
      currentLetter = firstLetter;
      section = [[AlphaSection alloc] init];
      section.name = firstLetter;
      section.items = [NSMutableArray array];
      [sections addObject:section];
      
    } else {
      
      section = [sections lastObject];
    }
    [section.items addObject:string];
  }
  return sections;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.contentWithSections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[self.contentWithSections[section] items] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return [self.contentWithSections[section] name];
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
  NSMutableArray *names = [NSMutableArray array];
  for (AlphaSection *section in self.contentWithSections) {
    [names addObject:section.name];
  }
  return names;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  
  AlphaSection *section = self.contentWithSections[indexPath.section];
  cell.textLabel.text = section.items[indexPath.row];
  
  return cell;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
  [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
  searchBar.text = nil;
  [searchBar resignFirstResponder];
  [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
  [self sectionsFromArrayInBackground:self.contentWithNames withFilter:searchText];
}

@end
