//
//  MasterViewController.m
//  Lesson7HW
//
//  Created by Oleg Tverdokhleb on 07.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "Constants.h"
#import "MasterViewController.h"
#import "DetailedViewController.h"

@interface MasterViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *notifications;

- (IBAction)actionAddButton:(id)sender;

@end

@implementation MasterViewController

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setup];
    [self reloadTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setup

- (void)setup {
    [self setupNotificationsArray];
    [self setupRefreshControl];
}

- (void)setupNotificationsArray {
    self.notifications = [NSMutableArray array];
    [self.notifications removeAllObjects];
    NSArray *array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    [self.notifications addObjectsFromArray:array];
}

- (void)setupRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(reloadTableView)
             forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

- (void)reloadTableView {
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                  withRowAnimation:UITableViewRowAnimationMiddle];
    [self.refreshControl endRefreshing];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.notifications count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UILocalNotification *notification = [self.notifications objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [notification.userInfo objectForKey:kScheduleText];
    cell.detailTextLabel.text = [notification.userInfo objectForKey:kScheduleDate];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UILocalNotification *notification = [self.notifications objectAtIndex:indexPath.row];
    DetailedViewController *vc = [self.storyboard
                                  instantiateViewControllerWithIdentifier:
                                  @"DetailedViewController"];
    
    vc.stringCurrentSchedule = [notification.userInfo objectForKey:kScheduleText];
    vc.date = notification.fireDate;
    vc.isNewSchedule = NO;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Action

- (IBAction)actionAddButton:(id)sender {
    DetailedViewController *vc = [self.storyboard
                                  instantiateViewControllerWithIdentifier:
                                  @"DetailedViewController"];
    vc.isNewSchedule = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
