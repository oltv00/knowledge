//
//  MRQAddNewUserTableViewController.m
//  41-44_CoreDataHWRestoProg
//
//  Created by Oleg Tverdokhleb on 11.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQAddNewUserTableViewController.h"
#import "MRQAddNewUserTableViewCell.h"

@interface MRQAddNewUserTableViewController ()

@end

@implementation MRQAddNewUserTableViewController

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifierNameCell = @"nameCell";
    static NSString *identifierFamilyCell = @"familyCell";
    static NSString *identifierEmailCell = @"emailCell";
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            MRQAddNewUserTableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:identifierNameCell];
            aCell.nameLabel.text = @"1";
            return aCell;
        } else if (indexPath.row == 1) {
            UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:identifierFamilyCell];
            return aCell;
        } else if (indexPath.row == 2) {
            UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:identifierEmailCell];
            return aCell;
        }
    }
    return nil;
}

@end
