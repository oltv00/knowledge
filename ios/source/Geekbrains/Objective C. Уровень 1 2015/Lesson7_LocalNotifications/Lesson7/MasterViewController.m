//
//  MasterViewController.m
//  Lesson7
//
//  Created by Oleg Tverdokhleb on 07.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailedViewController.h"

@interface MasterViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *notifications;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)actionAddButton:(id)sender;

@end

@implementation MasterViewController

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.notifications = [NSMutableArray array];
}

-(void)viewDidAppear:(BOOL)animated {
    
    [self.notifications removeAllObjects];
    NSArray *array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    [self.notifications addObjectsFromArray:array];

    if ([self.notifications count] > 0) {
        [self reloadTableView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Additional methods

- (void)reloadTableView {
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                  withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.notifications count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    UILocalNotification *notification = [self.notifications objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [notification.userInfo objectForKey:@"event"];
    cell.detailTextLabel.text = [notification.userInfo objectForKey:@"eventDate"];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UILocalNotification *notification = [self.notifications objectAtIndex:indexPath.row];

    DetailedViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailedViewController"];
    
    vc.currentEvent = [notification.userInfo objectForKey:@"event"];
    vc.date = notification.fireDate;
    NSLog(@"%@",vc.date);
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Action

- (IBAction)actionAddButton:(id)sender {
    
    DetailedViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailedViewController"];
    vc.isNewEvent = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
