//
//  MRQStudentListTableViewController.m
//  40_KVC&KVORestoProg
//
//  Created by Oleg Tverdokhleb on 27.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQStudentListTableViewController.h"
#import "MRQStudentTableViewCell.h"
#import "MRQStudent.h"

#import "MRQStudentCreateTableViewController.h"

@interface MRQStudentListTableViewController ()

@end

@implementation MRQStudentListTableViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (IBAction)actionAddBarButton:(id)sender {
    
    MRQStudentCreateTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MRQStudentCreateTableViewController"];
    
}

- (IBAction)actionEditBarButton:(id)sender {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MRQStudentTableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"studentCell"];
    
    aCell.image.image = [UIImage imageNamed:@"st-1.png"];
    aCell.name.text = @"testName";
    aCell.lastName.text = @"testLastName";
    aCell.dateOfBirth.text = @"10.11.91";
    aCell.gender.text = @"Male";
    aCell.grade.text = @"testGrade";
    
    return aCell;
}

#pragma mark - UITableViewDelegate

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"createStudent"]) {
        NSLog(@"MRQStudentCreateTableViewController");
    }
}

@end
