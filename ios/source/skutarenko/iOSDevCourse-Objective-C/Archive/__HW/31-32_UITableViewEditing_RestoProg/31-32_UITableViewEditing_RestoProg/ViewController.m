//
//  ViewController.m
//  31-32_UITableViewEditing_RestoProg
//
//  Created by Oleg Tverdokhleb on 29.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import "MRQDataModel.h"

typedef enum {
    UIBarButtonSideLeft,
    UIBarButtonSideRight
} UIBarButtonSide;

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *groupsOfStudentsArray;

@end

@implementation ViewController

#pragma mark Default VC methods

- (void) loadView {
    [super loadView];
    
    [self initNavController];
    [self initTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initPropertys];
    //[self initDataInTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Initial methods

- (void) initPropertys {
    
    self.groupsOfStudentsArray = [NSMutableArray array];
}

- (void) initTableView {
    
    CGRect tableViewFrame = self.view.bounds;
    tableViewFrame.origin = CGPointZero;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStyleGrouped];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void) initNavController {
    
    [self.navigationItem setTitle:@"Table Data"];
    
    [self createBarButton:UIBarButtonSystemItemEdit
               withAction:@selector(rightBarButtonAction:)
                   onSide:UIBarButtonSideRight];
    
    [self createBarButton:UIBarButtonSystemItemAdd
               withAction:@selector(leftBarButtonAction:)
                   onSide:UIBarButtonSideLeft];
}

- (void) initDataInTableView {
    
    for (int groups = 0; groups < ((arc4random() % 6) + 5); groups++) {
        MRQDataModel *group = [MRQDataModel initialGroupWithIndex:groups];
        NSMutableArray *array = [NSMutableArray array];
        
        for (int students = 0; students < (arc4random() % 11 + 5); students++) {
            [array addObject:[MRQDataModel initialStudent]];
        }
        
        group.students = array;
        [self.groupsOfStudentsArray addObject:group];
    }
    
    [self.tableView reloadData];
}
# pragma mark - Action methods

- (void) rightBarButtonAction:(UIBarButtonItem *) sender {
    
    BOOL isEditing = self.tableView.editing;
    [self.tableView setEditing:!isEditing animated:YES];
    
    if (self.tableView.editing) {
        [self createBarButton:UIBarButtonSystemItemDone
                   withAction:@selector(rightBarButtonAction:)
                       onSide:UIBarButtonSideRight];
        
        [self addRowToAddNewRows:YES];
        
    } else {
        
        [self createBarButton:UIBarButtonSystemItemEdit
                   withAction:@selector(rightBarButtonAction:)
                       onSide:UIBarButtonSideRight];
        
        [self addRowToAddNewRows:NO];
    }
}

- (void) leftBarButtonAction:(UIBarButtonItem *) sender {

    [self addNewSection];
}

#pragma mark - Optional methods

- (UIColor *) generateRandomColor {
    
    CGFloat r = (CGFloat)(arc4random() % 256) / 255;
    CGFloat g = (CGFloat)(arc4random() % 256) / 255;
    CGFloat b = (CGFloat)(arc4random() % 256) / 255;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}

- (UITableViewCell *) createDataCell:(UITableViewCell *) dataCell atIndexPath:(NSIndexPath *) indexPath {

    MRQDataModel *group = [self.groupsOfStudentsArray objectAtIndex:indexPath.section];
    MRQDataModel *student = [group.students objectAtIndex:indexPath.row];
    
    dataCell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
    dataCell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f", student.averageGrade];
    
    [self changeColorInCell:dataCell byStudentAverage:student.averageGrade];
    
    return dataCell;
}

- (UITableViewCell *) createInsertCell {
    
    if (self.tableView.editing == YES) {
        UITableViewCell *insertCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"insertCell"];
        
        return insertCell;
    }
    
    return nil;
}

- (void) createBarButton:(UIBarButtonSystemItem) systemItem withAction:(SEL) selector onSide:(UIBarButtonSide) side {
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:systemItem
                                  target:self action:selector];
    
    if (side == UIBarButtonSideLeft) {
        [self.navigationItem setLeftBarButtonItem:barButton animated:YES];
    } else if (side == UIBarButtonSideRight) {
        [self.navigationItem setRightBarButtonItem:barButton animated:YES];
    }
}

- (void) changeColorInCell:(UITableViewCell *) cell byStudentAverage:(NSInteger) averageGrade {
    
    if (averageGrade > 4.5f) {
        cell.detailTextLabel.textColor = [UIColor greenColor];
    } else if (averageGrade > 3.5f) {
        cell.detailTextLabel.textColor = [UIColor orangeColor];
    } else {
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
}

- (void) addRowToAddNewRows:(BOOL) add {
    
    static const int index = 0;
    
    for (int section = 0; section < [self.groupsOfStudentsArray count]; section++) {
        
        MRQDataModel *group = [self.groupsOfStudentsArray objectAtIndex:section];
        MRQDataModel *emptyModel = [[MRQDataModel alloc] init];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:section];
        
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:group.students];

        if (add) {

            [tempArray insertObject:emptyModel atIndex:index];
            group.students = tempArray;
            
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            [self.tableView endUpdates];

        } else {

            [tempArray removeObject:[tempArray objectAtIndex:index]];
            group.students = tempArray;

            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self.tableView endUpdates];
        }
    }
}

- (void) addNewSection {
    
    static NSInteger newSectionIndex = 0;
    
    MRQDataModel *group = [[MRQDataModel alloc] init];
    group.name = [NSString stringWithFormat:@"Group #%ld", newSectionIndex];
    group.students = @[];
    
    [self.groupsOfStudentsArray insertObject:group atIndex:newSectionIndex];
    
    NSIndexSet *insertIndexSet = [NSIndexSet indexSetWithIndex:newSectionIndex];
    
    newSectionIndex += 1;
    
    [self.tableView beginUpdates];
    [self.tableView insertSections:insertIndexSet withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSInteger index = 0;
    
    CGRect originalRect = cell.frame;
    
    CGRect shiftLeftRect = CGRectMake(0 - CGRectGetWidth(cell.frame),
                                  CGRectGetMinY(cell.frame),
                                  CGRectGetWidth(cell.frame),
                                  CGRectGetHeight(cell.frame));
    
    CGRect shiftRightRect = CGRectMake(2 * CGRectGetWidth(cell.frame),
                                      CGRectGetMinY(cell.frame),
                                      CGRectGetWidth(cell.frame),
                                      CGRectGetHeight(cell.frame));
    
    
    cell.frame = (index % 2) ? shiftLeftRect : shiftRightRect;
    
    index += 1;
    
    [UIView animateWithDuration:0.3f
                          delay:0.1f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         cell.backgroundColor = [self generateRandomColor];
                         cell.frame = originalRect;
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.5f
                                          animations:^{
                                              
                                              cell.backgroundColor = [UIColor whiteColor];
                                          }];
                     }];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return UITableViewCellEditingStyleInsert;
    }
    
    return UITableViewCellEditingStyleDelete;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    if (proposedDestinationIndexPath.row == 0) {
        return sourceIndexPath;
    } else {
        return proposedDestinationIndexPath;
    }
}

#pragma mark - UITableViewDataSource

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [[self.groupsOfStudentsArray objectAtIndex:section] name];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.groupsOfStudentsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    MRQDataModel *group = [self.groupsOfStudentsArray objectAtIndex:section];
    
    return [group.students count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *insertCellIdentifier = @"insertCell";
    UITableViewCell *insertCell = [self.tableView dequeueReusableCellWithIdentifier:insertCellIdentifier];
    
    if (self.tableView.editing == YES && indexPath.row == 0) {
        insertCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:insertCellIdentifier];
        insertCell.textLabel.text = @"Tap to add";
        insertCell.textLabel.textColor = [UIColor blueColor];
        
        return insertCell;
    }

    static NSString *dataCellIdentifier = @"dataCell";
    UITableViewCell *dataCell = [tableView dequeueReusableCellWithIdentifier:dataCellIdentifier];
    
    if (!dataCell) {
        dataCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:dataCellIdentifier];
    }
    
    dataCell = [self createDataCell:dataCell atIndexPath:indexPath];
    
    return dataCell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.row > 0;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    MRQDataModel *sourceGroup = [self.groupsOfStudentsArray objectAtIndex:sourceIndexPath.section];
    MRQDataModel *sourceModel = [sourceGroup.students objectAtIndex:sourceIndexPath.row];
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:sourceGroup.students];
    
    if (sourceIndexPath.section == destinationIndexPath.section) {
        [tempArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
        sourceGroup.students = tempArray;
        
    } else {
        
        [tempArray removeObject:sourceModel];
        sourceGroup.students = tempArray;
        
        MRQDataModel *destinationGroup = [self.groupsOfStudentsArray objectAtIndex:destinationIndexPath.section];
        tempArray = [NSMutableArray arrayWithArray:destinationGroup.students];
        [tempArray insertObject:sourceModel atIndex:destinationIndexPath.row];
        destinationGroup.students = tempArray;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        MRQDataModel *group = [self.groupsOfStudentsArray objectAtIndex:indexPath.section];
        MRQDataModel *model = [group.students objectAtIndex:indexPath.row];
        
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:group.students];
        [tempArray removeObject:model];
        group.students = tempArray;
        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView endUpdates];

    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        static NSInteger newStudentIndex = 0;
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:indexPath.row + 1 inSection:indexPath.section];
        
        MRQDataModel *group = [self.groupsOfStudentsArray objectAtIndex:indexPath.section];
        MRQDataModel *model = [MRQDataModel initialStudent];
        
        NSMutableArray *tempArray = nil;
        if (group.students) {
            tempArray = [NSMutableArray arrayWithArray:group.students];
        } else {
            tempArray = [NSMutableArray array];
        }
        
        [tempArray insertObject:model atIndex:newStudentIndex];
        group.students = tempArray;
        
        [tableView beginUpdates];
        [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
    }
}
@end
