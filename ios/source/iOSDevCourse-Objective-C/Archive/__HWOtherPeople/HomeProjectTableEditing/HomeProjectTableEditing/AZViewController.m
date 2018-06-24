//
//  AZViewController.m
//  HomeProjectTableEditing
//
//  Created by Alex Alexandrov on 11.01.14.
//  Copyright (c) 2014 Alex Zbirnik. All rights reserved.
//

#import "AZViewController.h"
#import "AZStudent.h"
#import "AZGroup.h"

@interface AZViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;
@property (weak, nonatomic) UILabel *foterLabel;
@property (strong, nonatomic) NSMutableArray *groupsArray;

@property (strong, nonatomic) UIColor *myColorBlack;
@property (strong, nonatomic) UIColor *myColorBlue;
@property (strong, nonatomic) UIColor *myColorRed;
@property (strong, nonatomic) UIColor *myColorWhite;
@property (strong, nonatomic) UIColor *myColorBrown;

@end

@implementation AZViewController

- (void) loadView {
    
    [super loadView];
    
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UIEdgeInsets inset;
    inset.left = 0;
    tableView.separatorInset = inset;

    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.allowsSelectionDuringEditing = NO;
    
    self.myColorBlack = [UIColor colorWithRed:15.f / 255.f green:14.f / 255.f blue:15.f / 255.f alpha:1.0];
    self.myColorBlue = [UIColor colorWithRed:31.f / 255.f green:51.f / 255.f blue:82.f / 255.f alpha:1.0];
    self.myColorRed = [UIColor colorWithRed:220.f / 255.f green:54.f / 255.f blue:16.f / 255.f alpha:1.0];
    self.myColorBrown = [UIColor colorWithRed:217.f / 255.f green:203.f / 255.f blue:158.f / 255.f alpha:1.0];
    self.myColorWhite = [UIColor whiteColor];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.groupsArray = [NSMutableArray array];
    
    for(int i = 0; i < arc4random() % 6 + 5; i++) {
        
        AZGroup *group = [[AZGroup alloc] init];
        group.name = [NSString stringWithFormat:@"Group #%d", i];
        
        NSMutableArray *array = [NSMutableArray array];
        
        for(int j = 0; j < arc4random() % 11 + 15; j++) {
            
            [array addObject:[AZStudent randomStudent]];
        }
        
        group.students = array;
        [self.groupsArray addObject:group];
    }

    [self.tableView reloadData];
    
    self.navigationItem.title = @"Students";
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self
                                                                                action:@selector(actionEdit:)];
    
    self.navigationItem.rightBarButtonItem = editButton;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                target:self
                                                                                action:@selector(actionAddSection:)];
    
    self.navigationItem.leftBarButtonItem = addButton;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void) actionEdit: (UIBarButtonItem *) sender {
    
    BOOL isEditing = self.tableView.editing;
    
    [self.tableView setEditing:!isEditing animated:YES];
    
    UIBarButtonSystemItem item = UIBarButtonSystemItemEdit;
    
    if(self.tableView.editing) {
        
        item = UIBarButtonSystemItemDone;
    }
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item
                                                                                target:self
                                                                                action:@selector(actionEdit:)];
    
    [self.navigationItem setRightBarButtonItem:editButton animated:YES];
}

- (void) actionAddSection: (UIBarButtonItem *) sender {
    
    AZGroup *group = [[AZGroup alloc] init];
    group.name = [NSString stringWithFormat: @"Group #%d", [self.groupsArray count] + 1];
    group.students = @[[AZStudent randomStudent], [AZStudent randomStudent]];
    
    NSInteger newSectionInteger = 0;
    
    [self.groupsArray insertObject:group atIndex:newSectionInteger];
    
    [self.tableView beginUpdates];
    
    NSIndexSet *insertSections = [NSIndexSet indexSetWithIndex:newSectionInteger];
    [self.tableView insertSections:insertSections withRowAnimation:UITableViewRowAnimationTop];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    });
    
    [self.tableView endUpdates];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.groupsArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *string = [[self.groupsArray objectAtIndex:section] name];
    return string;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    return @"I'm footer!!!";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[[self.groupsArray objectAtIndex:section] students] count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0) {
        
        static NSString *addSudentIdentifier = @"AddStudentCell";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:addSudentIdentifier];
        
        if(!cell){
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:addSudentIdentifier];
            
            cell.textLabel.textColor = self.myColorBlue;
            cell.textLabel.text = @"Add student";
            
        }
        return cell;
    }
    else {
        
        static NSString *identifier = @"Cell";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
        
        if(!cell){
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:identifier];
            
        }
        
        AZGroup *group = [self.groupsArray objectAtIndex:indexPath.section];
        AZStudent *student = [group.students objectAtIndex:indexPath.row - 1];
        
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f", student.averageGrade];
        
        if(student.averageGrade >= 4.0) {
            
            cell.detailTextLabel.textColor = self.myColorBlack;
        }
        else if(student.averageGrade >= 3.0) {
            
            cell.detailTextLabel.textColor = self.myColorBlue;
        }
        else {
            
            cell.detailTextLabel.textColor = self.myColorRed;
        }
        
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath.row > 0;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    AZGroup *sourceGroup = [self.groupsArray objectAtIndex:sourceIndexPath.section];
    AZStudent *student = [sourceGroup.students objectAtIndex:sourceIndexPath.row - 1];
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:sourceGroup.students];
    
    if(sourceIndexPath.section == destinationIndexPath.section) {
        
        [tempArray exchangeObjectAtIndex:sourceIndexPath.row - 1 withObjectAtIndex:destinationIndexPath.row - 1];
        sourceGroup.students = tempArray;
    }
    else {
        
        [tempArray removeObject:student];
        sourceGroup.students = tempArray;
        
        AZGroup *destinationGroup = [self.groupsArray objectAtIndex:destinationIndexPath.section];
        tempArray = [NSMutableArray arrayWithArray:destinationGroup.students];
        [tempArray insertObject:student atIndex:destinationIndexPath.row - 1];
        destinationGroup.students = tempArray;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        
        AZGroup *sourceGroup = [self.groupsArray objectAtIndex:indexPath.section];
        AZStudent *student = [sourceGroup.students objectAtIndex:indexPath.row - 1];
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:sourceGroup.students];
        
        [tempArray removeObject:student];
        sourceGroup.students = tempArray;
        
        [tableView beginUpdates];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        self.foterLabel.text = [NSString stringWithFormat:@"Student count: %d", [sourceGroup.students count]];
        
        [tableView endUpdates];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.frame = CGRectMake(0 - CGRectGetWidth(cell.frame), CGRectGetMinY(cell.frame),
                            CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame));
    
    [UIView animateWithDuration:0.3
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         cell.frame = CGRectMake(0, CGRectGetMinY(cell.frame),
                                                 CGRectGetWidth(cell.frame),
                                                 CGRectGetHeight(cell.frame));
                         
                         cell.backgroundColor = self.myColorBrown;
                         
                     } completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.2
                                          animations:^{
                                              
                                              cell.backgroundColor = [UIColor whiteColor];
                                          }];
                     }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                            CGRectGetWidth([tableView rectForHeaderInSection:section]),
                                                            CGRectGetHeight([tableView rectForHeaderInSection:section]))];
    headerView.backgroundColor = self.myColorRed;
    
    UILabel *headerTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0,
                                                                   CGRectGetWidth([tableView rectForHeaderInSection:section]),
                                                                   CGRectGetHeight([tableView rectForHeaderInSection:section]))];
    headerTextLabel.textColor = self.myColorWhite;
    headerTextLabel.text = [[self.groupsArray objectAtIndex:section] name];
    [headerView addSubview:headerTextLabel];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                            CGRectGetWidth([tableView rectForFooterInSection:section]),
                                                            CGRectGetHeight([tableView rectForFooterInSection:section]))];
    footerView.backgroundColor = self.myColorBlue;
    
    UILabel *footerTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0,
                                                                   CGRectGetWidth([tableView rectForFooterInSection:section]) - 20,
                                                                   CGRectGetHeight([tableView rectForFooterInSection:section]))];
    footerTextLabel.textColor = self.myColorWhite;
    footerTextLabel.textAlignment = NSTextAlignmentRight;
    AZGroup *stArray = [self.groupsArray objectAtIndex:section];
    footerTextLabel.text = [NSString stringWithFormat:@"Student count: %d", [stArray.students count]];
    [footerView addSubview:footerTextLabel];
    self.foterLabel = footerTextLabel;
    
    return footerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"Destroy";
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    if(proposedDestinationIndexPath.row == 0) {
        
        return sourceIndexPath;
    } else {
        
        return proposedDestinationIndexPath;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == 0) {
        
        AZGroup *group = [self.groupsArray objectAtIndex:indexPath.section];
        NSMutableArray *tempArray = nil;
        
        if(group.students) {
            tempArray = [NSMutableArray arrayWithArray:group.students];
        } else {
            tempArray = [NSMutableArray array];
        }
        
        NSInteger newStudentIndex = 0;
        [tempArray insertObject:[AZStudent randomStudent] atIndex:newStudentIndex];
        group.students = tempArray;
        
        [self.tableView beginUpdates];
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:newStudentIndex + 1 inSection:indexPath.section];
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationTop];
        self.foterLabel.text = [NSString stringWithFormat:@"Student count: %d", [group.students count]];
        
        [self.tableView endUpdates];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        double delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            if([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
                
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            }
        });
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.row == 0 ? UITableViewCellEditingStyleNone : UITableViewCellEditingStyleDelete;
}



@end
