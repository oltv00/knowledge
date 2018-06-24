//
//  ViewController.m
//  31_UITableViewEditing_TableEditingTest
//
//  Created by Oleg Tverdokhleb on 29.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import "MRQGroup.h"
#import "MRQStudent.h"

typedef NS_ENUM(NSInteger, UIBarButtonSystemItemSide) {
    
    UIBarButtonSystemItemSideRight,
    UIBarButtonSystemItemSideLeft
};

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *groupsArray;

@end

@implementation ViewController

#pragma mark - DefVC methods

- (void) loadView {
    [super loadView];
    
    [self navControllerSetup];
    
    self.tableView = [self createTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    //[self createGroupsAndStudents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Initial

- (void) initialize {
    
    self.groupsArray = [NSMutableArray array];
}

- (void) navControllerSetup {
    
    self.navigationItem.title = @"Students";
    
    [self createNavButtonWithStyle:UIBarButtonSystemItemEdit
                         onTheSide:UIBarButtonSystemItemSideRight
                        withAction:@selector(actionEdit:)];

    [self createNavButtonWithStyle:UIBarButtonSystemItemAdd
                         onTheSide:UIBarButtonSystemItemSideLeft
                        withAction:@selector(actionAddSection:)];
}

- (UITableView *) createTableView {

    CGRect tableViewFrame = self.view.bounds;
    tableViewFrame.origin = CGPointZero;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStyleGrouped];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.allowsSelectionDuringEditing = NO;
    
    [self.view addSubview:tableView];

    return tableView;
}

- (void) createGroupsAndStudents {
    
    for (int groups = 0; groups < ((arc4random() % 6) + 5); groups++) {
        
        MRQGroup *group = [[MRQGroup alloc] init];
        group.name = [NSString stringWithFormat:@"Group #%d", groups];
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (int students = 0; students < ((arc4random() % 11) + 5); students++) {
            [array addObject:[MRQStudent generateRandomStudent]];
        }
        
        group.students = array;
        
        [self.groupsArray addObject:group];
    }
    
    [self.tableView reloadData];
}

- (void) createNavButtonWithStyle:(UIBarButtonSystemItem) systemItem onTheSide:(UIBarButtonSystemItemSide) side withAction:(SEL) SEL_Action {
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem
                                                                                   target:self
                                                                                   action:SEL_Action];
    if (side == UIBarButtonSystemItemSideLeft) {
        [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    } else {
        [self.navigationItem setRightBarButtonItem:barButtonItem animated:YES];
    }
}


#pragma mark - Actions

- (void) actionEdit:(UIBarButtonItem *) sender {

    BOOL isEditing = self.tableView.editing;
    
    [self.tableView setEditing:!isEditing animated:YES];
    
    if (self.tableView.editing) {
        [self createNavButtonWithStyle:UIBarButtonSystemItemDone
                             onTheSide:UIBarButtonSystemItemSideRight
                            withAction:@selector(actionEdit:)];
    } else {
        [self createNavButtonWithStyle:UIBarButtonSystemItemEdit
                             onTheSide:UIBarButtonSystemItemSideRight
                            withAction:@selector(actionEdit:)];
    }
}

- (void) actionAddSection:(UIBarButtonItem *) sender {
    
    static NSInteger newSectionIndex = 0;
    
    MRQGroup *group = [[MRQGroup alloc] init];
    group.name = [NSString stringWithFormat:@"Group #%ld", [self.groupsArray count] + 1];
    group.students = @[];

    [self.groupsArray insertObject:group atIndex:newSectionIndex];

    UITableViewRowAnimation animation = UITableViewRowAnimationFade;
    
    [self.tableView beginUpdates];

    NSIndexSet *insertSections = [NSIndexSet indexSetWithIndex:newSectionIndex];

    if ([self.groupsArray count] > 1) {
        [self.tableView insertSections:insertSections
                      withRowAnimation:[self.groupsArray count] % 2 ? UITableViewRowAnimationLeft : UITableViewRowAnimationRight];

    }
    
    [self.tableView insertSections:insertSections
                  withRowAnimation:animation];
    
    [self.tableView endUpdates];
    
    [self beginIgnoringInteractionEventsFor:0.3f];
}

#pragma mark - MRQ methods

- (UITableViewCell *) colored:(UITableViewCell *) aCell byAverageStudent:(CGFloat) average {
    
    if (average > 4.5f) {
        aCell.detailTextLabel.textColor = [UIColor greenColor];
    } else if (average > 3.f) {
        aCell.detailTextLabel.textColor = [UIColor orangeColor];
    } else {
        aCell.detailTextLabel.textColor = [UIColor redColor];
    }
    
    return aCell;
}

- (void) beginIgnoringInteractionEventsFor:(CGFloat) seconds {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    });
}

- (void) addStudentForIndexPath:(NSIndexPath *) indexPath {
    
    MRQGroup *group = [self.groupsArray objectAtIndex:indexPath.section];
    
    NSMutableArray *tempArray = nil;
    if (group.students) {
        tempArray = [NSMutableArray arrayWithArray:group.students];
    } else {
        tempArray = [NSMutableArray array];
    }
    
    static NSInteger newStudentIndex = 0;
    
    [tempArray insertObject:[MRQStudent generateRandomStudent] atIndex:newStudentIndex];
    group.students = tempArray;
    
    [self.tableView beginUpdates];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:newStudentIndex + 1 inSection:indexPath.section];
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
    [self beginIgnoringInteractionEventsFor:0.3f];

}

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {

    return indexPath.row == 0 ? UITableViewCellEditingStyleNone : UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    if (proposedDestinationIndexPath.row == 0) {
        
        return sourceIndexPath;
    } else {
        
        return proposedDestinationIndexPath;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self addStudentForIndexPath:indexPath];
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"DON'T TOUCH!";
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.groupsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    MRQGroup *group = [self.groupsArray objectAtIndex:section];
    
    return [group.students count] + 1;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [[self.groupsArray objectAtIndex:section] name];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *studentCellIdentifier = @"studentCell";
    static NSString *addRowCellIdentifier = @"addRowCell";
    
    if (indexPath.row == 0) {
        UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:addRowCellIdentifier];

        if (!aCell) {
            aCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addRowCellIdentifier];
            aCell.textLabel.text = @"Tap to add new row";
            aCell.textLabel.textColor = [UIColor blueColor];
        }
        
        return aCell;
    }
    
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:studentCellIdentifier];
    
    if (!aCell) {
        aCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:studentCellIdentifier];
    }
    
    MRQGroup *group = [self.groupsArray objectAtIndex:indexPath.section];
    MRQStudent *student = [group.students objectAtIndex:indexPath.row - 1];
    
    aCell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
    aCell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f", student.average];
    
    aCell = [self colored:aCell byAverageStudent:student.average];
    
    return aCell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
    MRQGroup *group = [self.groupsArray objectAtIndex:indexPath.section];
    MRQStudent *student = [group.students objectAtIndex:indexPath.row];
    
    return student.average < 4;
    */
    
    return indexPath.row > 0;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    MRQGroup *sourceGroup = [self.groupsArray objectAtIndex:sourceIndexPath.section];
    MRQStudent *student = [sourceGroup.students objectAtIndex:sourceIndexPath.row - 1];
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:sourceGroup.students];
    
    if (sourceIndexPath.section == destinationIndexPath.section) {
        [tempArray exchangeObjectAtIndex:sourceIndexPath.row - 1 withObjectAtIndex:destinationIndexPath.row - 1];
        sourceGroup.students = tempArray;
    } else {
        
        [tempArray removeObject:student];
        sourceGroup.students = tempArray;
        
        MRQGroup *destinationGroup = [self.groupsArray objectAtIndex:destinationIndexPath.section];
        tempArray = [NSMutableArray arrayWithArray:destinationGroup.students];
        [tempArray insertObject:student atIndex:destinationIndexPath.row - 1];
        destinationGroup.students = tempArray;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        MRQGroup *group = [self.groupsArray objectAtIndex:indexPath.section];
        MRQStudent *student = [group.students objectAtIndex:indexPath.row];
        
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:group.students];
        [tempArray removeObject:student];
        group.students = tempArray;
        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [tableView endUpdates];
    }
}

@end
