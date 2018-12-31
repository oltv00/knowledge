//
//  ASViewController.m
//  TableEditingTest
//
//  Created by Oleksii Skutarenko on 23.12.13.
//  Copyright (c) 2013 Alex Skutarenko. All rights reserved.
//

#import "ASViewController.h"
#import "ASStudent.h"
#import "ASGroup.h"

@interface ASViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* groupsArray;

@end

@implementation ASViewController


- (void) loadView {
    
    [super loadView];
    
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    
    tableView.editing = YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.groupsArray = [NSMutableArray array];
    
    for (int i = 0; i < ((arc4random() % 6) + 5); i++) {
        
        ASGroup* group = [[ASGroup alloc] init];
        group.name = [NSString stringWithFormat:@"Group #%d", i];
        
        NSMutableArray* array = [NSMutableArray array];
        
        for (int j = 0; j < ((arc4random() % 11) + 15); j++) {
            [array addObject:[ASStudent randomStudent]];
        }
        
        group.students = array;
        
        [self.groupsArray addObject:group];
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.groupsArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [[self.groupsArray objectAtIndex:section] name];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    ASGroup* group = [self.groupsArray objectAtIndex:section];
    
    return [group.students count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    ASGroup* group = [self.groupsArray objectAtIndex:indexPath.section];
    ASStudent* student = [group.students objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f", student.averageGrade];
    
    if (student.averageGrade >= 4.0) {
        cell.detailTextLabel.textColor = [UIColor greenColor];
    } else if (student.averageGrade >= 3.0) {
        cell.detailTextLabel.textColor = [UIColor orangeColor];
    } else {
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
    ASGroup* sourceGroup = [self.groupsArray objectAtIndex:indexPath.section];
    ASStudent* student = [sourceGroup.students objectAtIndex:indexPath.row];
    
    return student.averageGrade < 4.f;
    */
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    ASGroup* sourceGroup = [self.groupsArray objectAtIndex:sourceIndexPath.section];
    ASStudent* student = [sourceGroup.students objectAtIndex:sourceIndexPath.row];
    
    NSMutableArray* tempArray = [NSMutableArray arrayWithArray:sourceGroup.students];
    
    if (sourceIndexPath.section == destinationIndexPath.section) {
        
        [tempArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
        sourceGroup.students = tempArray;
        
    } else {
        
        [tempArray removeObject:student];
        sourceGroup.students = tempArray;
        
        ASGroup* destinationGroup = [self.groupsArray objectAtIndex:destinationIndexPath.section];
        tempArray = [NSMutableArray arrayWithArray:destinationGroup.students];
        [tempArray insertObject:student atIndex:destinationIndexPath.row];
        destinationGroup.students = tempArray;
        
    }
    
}

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

@end
