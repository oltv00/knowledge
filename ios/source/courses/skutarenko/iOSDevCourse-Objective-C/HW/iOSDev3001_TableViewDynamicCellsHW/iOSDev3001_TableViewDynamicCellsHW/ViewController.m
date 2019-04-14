//
//  ViewController.m
//  iOSDev3001_TableViewDynamicCellsHW
//
//  Created by Oleg Tverdokhleb on 24.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import "OTStudent.h"

typedef NS_ENUM(NSInteger, StudentGroup) {
  StudentGroupBestStudents,
  StudentGroupGoodStudents,
  StudentGroupNormalStudents,
  StudentGroupBadStudents
};

@interface ViewController ()

@property (strong, nonatomic) NSArray *groups;

@end

@implementation ViewController

#pragma mark - View lifecycles
- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
  self.tableView.contentInset = inset;
  self.tableView.scrollIndicatorInsets = inset;
  
  self.groups = [OTStudent initStudentsWithCount:30];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.groups count] + 1;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  switch (section) {
    case StudentGroupBestStudents:
      return @"Best Students";
      break;
    case StudentGroupGoodStudents:
      return @"Good Students";
      break;
    case StudentGroupNormalStudents:
      return @"Normal Students";
      break;
    case StudentGroupBadStudents:
      return @"Bad Students";
      break;
    case 4:
      return @"Colors";
      break;
    default:
      break;
  }
  return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 4) {
    return 10;
  }
  
  NSArray *group = self.groups[section];
  return [group count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *studentIdentifier = @"students";
  static NSString *colorIdentifier = @"colors";
  
  if (indexPath.section == 4) {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:colorIdentifier];
    if (!cell) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:colorIdentifier];
    }
    
    CGFloat r = (CGFloat)arc4random_uniform(255)/256;
    CGFloat g = (CGFloat)arc4random_uniform(255)/256;
    CGFloat b = (CGFloat)arc4random_uniform(255)/256;
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = [NSString stringWithFormat:@"RGB: {%.0f %.0f %.0f}", r*256, g*256, b*256];
    cell.backgroundColor = color;
    
    return cell;
    
  } else {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:studentIdentifier];
    if (!cell) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:studentIdentifier];
    }
    
    NSArray *group = self.groups[indexPath.section];
    OTStudent *student = group[indexPath.row];
    
    if (student.averageScore < 3) {
      cell.textLabel.textColor = [UIColor redColor];
    } else {
      cell.textLabel.textColor = [UIColor blackColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.name, student.lastname];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", student.averageScore];
    
    return cell;
  }
}

@end
