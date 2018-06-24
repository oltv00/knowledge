//
//  OLTV_MainTableViewController.m
//  iOSDev3901_UIWebViewHW
//
//  Created by Oleg Tverdokhleb on 15/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

//model
#import "OLTVTableSection.h"
#import "OLTVURL.h"

//controller
#import "OLTVMainTableViewController.h"
#import "OLTVWebViewController.h"

@interface OLTVMainTableViewController ()
@property (strong, nonatomic) NSMutableArray *content;
@end

@implementation OLTVMainTableViewController

#pragma mark - Lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.content = [NSMutableArray array];
  [self addPDFFiles];
  [self addWebSites];
}

- (void)addPDFFiles {
  OLTVTableSection *section = [[OLTVTableSection alloc]
                                initWithSectionName:@"PDF"
                                contentType:OLTVTableSectionContentTypePDF];
  [self.content addObject:section];
}

- (void)addWebSites {
  OLTVTableSection *section = [[OLTVTableSection alloc]
                                initWithSectionName:@"Web Sites"
                                contentType:OLTVTableSectionContentTypeWeb];
  [self.content addObject:section];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.content count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[self.content[section] content] count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return [self.content[section] sectionName];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  
  OLTVTableSection *section = self.content[indexPath.section];
  OLTVURL *url = section.content[indexPath.row];
  
  cell.textLabel.text = url.urlName;
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  OLTVTableSection *section = self.content[indexPath.section];
  OLTVURL *url = section.content[indexPath.row];
  OLTVWebViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"OLTVWebViewController"];
  vc.request = url.URLRequest;
  [self presentViewController:vc animated:YES completion:nil];
}

@end
