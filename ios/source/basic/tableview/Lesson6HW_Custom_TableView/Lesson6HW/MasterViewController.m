//
//  MasterViewController.m
//  Lesson6HW
//
//  Created by Oleg Tverdokhleb on 06.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "Model.h"

#import "MasterViewController.h"
#import "DetailedViewController.h"

#import "MasterTableViewCell.h"


@interface MasterViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *mArray;
@property (strong, nonatomic) Model *model;

@end

@implementation MasterViewController

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setup {
    
    self.mArray = [Model initWithFirstLaunch];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.mArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MasterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    Model *model = [self.mArray objectAtIndex:indexPath.row];
    
    cell.cityNameLabel.text = model.city;
    cell.countryNameLabel.text = model.country;
    cell.cityImageView.image = [UIImage imageNamed:model.imageName];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Model *model = [self.mArray objectAtIndex:indexPath.row];
    DetailedViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailedViewController"];
    
    vc.imgView = model.imageName;
    vc.descrView = model.descr;
    
    [self showViewController:vc sender:model];
}

@end
