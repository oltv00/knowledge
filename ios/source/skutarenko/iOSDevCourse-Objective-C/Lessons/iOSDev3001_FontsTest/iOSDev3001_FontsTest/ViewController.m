//
//  ViewController.m
//  iOSDev3001_FontsTest
//
//  Created by Oleg Tverdokhleb on 24.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View lifecycles
- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  NSLog(@"numberOfSectionsInTableView");
  return [[UIFont familyNames] count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  NSArray *familyNames = [UIFont familyNames];
  NSString *familyName = familyNames[section];
  return familyName;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSLog(@"numberOfRowsInSection: %ld", section);
  
  NSArray *familyNames = [UIFont familyNames];
  NSString *familyName = familyNames[section];
  return [[UIFont fontNamesForFamilyName:familyName] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"cellForRowAtIndexPath : {%ld,%ld}", indexPath.section, indexPath.row);

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
  }
  
  NSArray *familyNames = [UIFont familyNames];
  NSString *familyName = familyNames[indexPath.section];
  NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
  UIFont *font = [UIFont fontWithName:fontNames[indexPath.row] size:14.f];
  
  cell.textLabel.text = [font fontName];
  cell.textLabel.font = font;

  return cell;
}

@end