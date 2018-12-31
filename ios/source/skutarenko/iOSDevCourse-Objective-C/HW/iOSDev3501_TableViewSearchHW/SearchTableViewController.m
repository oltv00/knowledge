//
//  SearchTableViewController.m
//  iOSDev3501_TableViewSearchHW
//
//  Created by Oleg Tverdokhleb on 01.05.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

//model
#import "Student.h"

//controller
#import "SearchTableViewController.h"

typedef NS_ENUM(NSInteger, SegmentedControlValue) {
  SegmentedControlValueBirthday,
  SegmentedControlValueName,
  SegmentedControlValueLastname
};

#pragma mark - Constants

static const NSInteger SearchTableViewControllerInitStudentCount = 30;

#pragma mark - Section class
@interface Section : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *items;
@end

@implementation Section
@end

#pragma mark - SearchTableViewController class
@interface SearchTableViewController ()

@property (strong, nonatomic) NSArray *initializedStudents;
@property (strong, nonatomic) NSArray *sortedStudents;
@property (strong, nonatomic) NSArray *content;
@property (strong, nonatomic) NSArray *indexTitles;

@property (strong, nonatomic) NSOperationQueue *operationQueue;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tableSortControl;

- (IBAction)actionControlValueChanged:(UISegmentedControl *)sender;

@property (strong, nonatomic) UIColor *blackColor;
@property (strong, nonatomic) UIColor *greenColor;

@end

@implementation SearchTableViewController

#pragma mark - View lifecycles
- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.blackColor = [UIColor colorWithRed:39.f / 255.f
                                      green:39.f / 255.f
                                       blue:39.f / 255.f alpha:1.0];
  
  self.greenColor = [UIColor colorWithRed:176.f / 255.f
                                      green:191.f / 255.f
                                       blue:90.f / 255.f alpha:1.0];
  
  __weak SearchTableViewController *weakSelf = self;
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    weakSelf.initializedStudents = [weakSelf initializeStudents];
    weakSelf.sortedStudents = [weakSelf sortedArrayByMonth:weakSelf.initializedStudents];
    [weakSelf generateSectionsInBackground:weakSelf.sortedStudents withFilter:weakSelf.searchBar.text];
  });
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  NSLog(@"didReceiveMemoryWarning");
}

#pragma mark - Additional
- (NSArray *)initializeStudents {
  return [Student initializeStudentsCount:SearchTableViewControllerInitStudentCount];
}

- (NSArray *)lastSortedArray:(NSArray *)inputArray {
  NSMutableArray *resultArray = [NSMutableArray arrayWithArray:inputArray];
  
  [resultArray sortUsingComparator:^NSComparisonResult(Student *obj1, Student *obj2) {
    
    if ([obj1.name compare:obj2.name] == NSOrderedAscending) {
      return NSOrderedAscending;
    } else if ([obj1.name compare:obj2.name] == NSOrderedDescending) {
      return NSOrderedDescending;
    } else if ([obj1.lastname compare:obj2.lastname] == NSOrderedAscending) {
      return NSOrderedAscending;
    } else if ([obj1.lastname compare:obj2.lastname] == NSOrderedDescending) {
      return NSOrderedDescending;
    } else if ([obj1.birthday compare:obj2.birthday] == NSOrderedAscending) {
      return NSOrderedAscending;
    } else if ([obj1.birthday compare:obj2.birthday] == NSOrderedDescending) {
      return NSOrderedDescending;
    } else {
      return NSOrderedSame;
    }
  }];
  return resultArray;
}

- (NSArray *)sortedArrayInSections:(NSArray *)inputArray {
  NSMutableArray *resultArray = [NSMutableArray array];
  for (Section *section in inputArray) {
    section.items = (NSMutableArray *)[self lastSortedArray:section.items];
    [resultArray addObject:section];
  }
  return resultArray;
}

- (void)generateSectionsInBackground:(NSArray *)inputArray withFilter:(NSString *)filterString {
  [self.operationQueue cancelAllOperations];
  
  __weak SearchTableViewController *weakSelf = self;
  self.operationQueue = [[NSOperationQueue alloc] init];
  [self.operationQueue addOperationWithBlock:^{
    
    switch (weakSelf.tableSortControl.selectedSegmentIndex) {
      case SegmentedControlValueBirthday:
        weakSelf.content = [weakSelf generateMonthSections:inputArray withFilter:filterString];
        break;
        
      case SegmentedControlValueName:
        weakSelf.content = [weakSelf generateNameSections:inputArray withFilter:filterString];
        break;
        
      case SegmentedControlValueLastname:
        weakSelf.content = [weakSelf generateLastnameSections:inputArray withFilter:filterString];
        break;
        
      default:
        break;
    }
    weakSelf.content = [weakSelf sortedArrayInSections:weakSelf.content];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      [weakSelf.tableView reloadData];
    });
  }];
}

- (NSArray *)generateSectionIndexTitlesByHeaders:(NSArray *)inputArray {
  switch (self.tableSortControl.selectedSegmentIndex) {
    case SegmentedControlValueBirthday:
      return [self generateSectionIndexTitlesByMonth:inputArray];
      break;
      
    case SegmentedControlValueName:
      return [self generateSectionIndexTitlesByName:inputArray];
      break;
      
    case SegmentedControlValueLastname:
      return [self generateSectionIndexTitlesByLastname:inputArray];
      break;
      
    default:
      return nil;
      break;
  }
}

#pragma mark Additional Sort by Month


- (NSArray *)sortedArrayByMonth:(NSArray *)inputArray {
  NSMutableArray *resultArray = [NSMutableArray arrayWithArray:inputArray];
  
  [resultArray sortUsingComparator:^NSComparisonResult(Student *obj1, Student *obj2) {
    
    NSInteger obj1Month = [obj1 getMonth:obj1.birthday];
    NSInteger obj2Month = [obj2 getMonth:obj2.birthday];
    
    if (obj1Month < obj2Month) {
      return NSOrderedAscending;
    } else if (obj1Month > obj2Month) {
      return NSOrderedDescending;
    } else {
      return NSOrderedSame;
    }
  }];
  return resultArray;
}

- (NSArray *)generateMonthSections:(NSArray *)inputArray withFilter:(NSString *)filterString {
  NSMutableArray *resultArray = [NSMutableArray array];
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"MMMM"];
  
  NSString *sectionDate = nil;
  for (Student *student in inputArray) {
    
    NSString *searchName = student.name;
    NSString *searchLastname = student.lastname;
    
    if ([filterString length] > 0) {
      if ([searchName rangeOfString:filterString].location == NSNotFound &&
          [searchLastname rangeOfString:filterString].location == NSNotFound) {
        continue;
      }
    }
    NSString *currentDate = [dateFormatter stringFromDate:student.birthday];
    Section *section = nil;
    
    if (![sectionDate isEqualToString:currentDate]) {
      sectionDate = currentDate;
      section = [[Section alloc] init];
      section.name = currentDate;
      section.items = [NSMutableArray array];
      [resultArray addObject:section];
      
    } else {
      section = [resultArray lastObject];
    }
    [section.items addObject:student];
  }
  
  return resultArray;
}

- (NSArray *)generateSectionIndexTitlesByMonth:(NSArray *)inputArray {
  NSMutableArray *resultArray = [NSMutableArray array];
  
  for (Section *section in inputArray) {
    NSString *dateString = [section.name substringToIndex:3];
    if (!dateString) {
      NSLog(@"generateSectionIndexTitlesByMonth dateString = %@", dateString);
      abort();
    }
    [resultArray addObject:dateString];
  }
  return resultArray;
}

#pragma mark Additional Sort by Name

- (NSArray *)sortedArrayByName:(NSArray *)inputArray {
  NSMutableArray *resultArray = [NSMutableArray arrayWithArray:inputArray];
  
  [resultArray sortUsingComparator:^NSComparisonResult(Student *obj1, Student *obj2) {
    if ([obj1.name compare:obj2.name] == NSOrderedAscending) {
      return NSOrderedAscending;
    } else if ([obj1.name compare:obj2.name] == NSOrderedDescending) {
      return NSOrderedDescending;
    } else {
      return NSOrderedSame;
    }
  }];
  return resultArray;
}

- (NSArray *)generateNameSections:(NSArray *)inputArray withFilter:(NSString *)filterString {
  NSMutableArray *resultArray = [NSMutableArray array];
  
  NSString *sectionName = nil;
  for (Student *student in inputArray) {
    
    NSString *searchName = student.name;
    NSString *searchLastname = student.lastname;
    
    if ([filterString length] > 0) {
      if ([searchName rangeOfString:filterString].location == NSNotFound &&
          [searchLastname rangeOfString:filterString].location == NSNotFound) {
        continue;
      }
    }
    
    NSString *currentName = [student.name substringToIndex:1];
    Section *section = nil;
    if (![sectionName isEqualToString:currentName]) {
      sectionName = currentName;
      section = [[Section alloc] init];
      section.name = currentName;
      section.items = [NSMutableArray array];
      [resultArray addObject:section];
      
    } else {
      section = [resultArray lastObject];
    }
    [section.items addObject:student];
  }
  
  return resultArray;
}

- (NSArray *)generateSectionIndexTitlesByName:(NSArray *)inputArray {
  NSMutableArray *resultArray = [NSMutableArray array];
  
  NSString *name = nil;
  for (Section *section in inputArray) {
    name = section.name;
    if (!name) {
      NSLog(@"generateSectionIndexTitlesByName %@", name);
      abort();
    }
    [resultArray addObject:name];
  }
  return resultArray;
}

#pragma mark Additional Sort by Lastname

- (NSArray *)sortedArrayByLastname:(NSArray *)inputArray {
  NSMutableArray *resultArray = [NSMutableArray arrayWithArray:inputArray];
  
  [resultArray sortUsingComparator:^NSComparisonResult(Student *obj1, Student *obj2) {
    if ([obj1.lastname compare:obj2.lastname] == NSOrderedAscending) {
      return NSOrderedAscending;
    } else if ([obj1.lastname compare:obj2.lastname] == NSOrderedDescending) {
      return NSOrderedDescending;
    } else {
      return NSOrderedSame;
    }
  }];
  return resultArray;
}

- (NSArray *)generateLastnameSections:(NSArray *)inputArray withFilter:(NSString *)filterString {
  NSMutableArray *resultArray = [NSMutableArray array];
  
  NSString *sectionLastname = nil;
  for (Student *student in inputArray) {
    
    NSString *searchName = student.name;
    NSString *searchLastname = student.lastname;
    
    if ([filterString length] > 0) {
      if ([searchName rangeOfString:filterString].location == NSNotFound &&
          [searchLastname rangeOfString:filterString].location == NSNotFound) {
        continue;
      }
    }
    
    NSString *currentLastname = [student.lastname substringToIndex:1];
    Section *section = nil;
    if (![sectionLastname isEqualToString:currentLastname]) {
      sectionLastname = currentLastname;
      section = [[Section alloc] init];
      section.name = currentLastname;
      section.items = [NSMutableArray array];
      [resultArray addObject:section];
      
    } else {
      section = [resultArray lastObject];
    }
    [section.items addObject:student];
  }
  
  return resultArray;
}

- (NSArray *)generateSectionIndexTitlesByLastname:(NSArray *)inputArray {
  NSMutableArray *resultArray = [NSMutableArray array];
  
  NSString *lastname = nil;
  for (Section *section in inputArray) {
    lastname = section.name;
    if (!lastname) {
      NSLog(@"generateSectionIndexTitlesByName %@", lastname);
      abort();
    }
    [resultArray addObject:lastname];
  }
  return resultArray;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.content count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[self.content[section] items] count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return [NSString stringWithFormat:@"%@ - %ld students", [self.content[section] name], [[self.content[section] items] count]];
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
  return [self generateSectionIndexTitlesByHeaders:self.content];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    cell.imageView.image = [UIImage imageNamed:@"student"];
  }
  
  Section *section = self.content[indexPath.section];
  Student *student = section.items[indexPath.row];
  
  NSString *fullName = [NSString stringWithFormat:@"%@ %@", student.name, student.lastname];
  cell.textLabel.text = fullName;
  cell.detailTextLabel.text = [student stringFromDate:student.birthday];
  
  if([self.searchBar.text length]){
    
    NSMutableAttributedString *as = [[NSMutableAttributedString alloc]  initWithString:fullName];
    [as addAttribute:NSForegroundColorAttributeName value:self.greenColor range:student.nameRange];
    [as addAttribute:NSForegroundColorAttributeName value:self.greenColor range:student.lastnameRange];
    
    [as addAttribute:NSBackgroundColorAttributeName value:self.blackColor range:student.nameRange];
    [as addAttribute:NSBackgroundColorAttributeName value:self.blackColor range:student.lastnameRange];
    
    cell.textLabel.attributedText = as;
  }
  
  return cell;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
  [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [searchBar resignFirstResponder];
  [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
  searchBar.text = @"";
  [searchBar resignFirstResponder];
  [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
  NSLog(@"%@", searchText);
  [self generateSectionsInBackground:self.sortedStudents withFilter:searchText];
}

#pragma mark - Action

- (IBAction)actionControlValueChanged:(UISegmentedControl *)sender {
  switch (sender.selectedSegmentIndex) {
    case SegmentedControlValueBirthday:
      NSLog(@"SegmentedControlValueBirthday");
      
      self.sortedStudents = [self sortedArrayByMonth:self.initializedStudents];
      [self generateSectionsInBackground:self.sortedStudents withFilter:self.searchBar.text];
      
      break;
    case SegmentedControlValueName:
      NSLog(@"SegmentedControlValueName");
      
      self.sortedStudents = [self sortedArrayByName:self.initializedStudents];
      [self generateSectionsInBackground:self.sortedStudents withFilter:self.searchBar.text];
      
      break;
    case SegmentedControlValueLastname:
      NSLog(@"SegmentedControlValueLastname");
      
      self.sortedStudents = [self sortedArrayByLastname:self.initializedStudents];
      [self generateSectionsInBackground:self.sortedStudents withFilter:self.searchBar.text];
      
      break;
    default:
      break;
  }
}
@end