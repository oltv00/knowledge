 //
//  RJEducationViewController.m
//  Lesson36Ex
//
//  Created by Hopreeeeenjust on 02.02.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import "RJEducationViewController.h"

@interface RJEducationViewController ()

@end

@implementation RJEducationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.lastIndexPath) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.lastIndexPath];
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (IBAction)actionDoneButtonPushed:(UIBarButtonItem *)sender {
    [self.delegate didChoseEducation:self.education atIndexPath:self.lastIndexPath];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.lastIndexPath) {
        [[tableView cellForRowAtIndexPath:self.lastIndexPath] setAccessoryType:UITableViewCellAccessoryNone];
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    if (cell.detailTextLabel.text) {
        self.education = [NSString stringWithFormat:@"%@ (%@)", cell.textLabel.text, cell.detailTextLabel.text];
    } else {
        self.education = cell.textLabel.text;
    }
    self.lastIndexPath = indexPath;
}


@end
