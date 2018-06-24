//
//  ViewController.m
//  35_UITableViewSearchRestoProg
//
//  Created by Oleg Tverdokhleb on 12.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import "MRQModelData.h"

typedef enum {
    
    sortByBirthDay,
    sortByName,
    sortByLastName
    
} DescriptorVariant;

@interface ViewController () <UISearchBarDelegate>

@property (strong, nonatomic) NSArray *sectionIndexArray;
@property (strong, nonatomic) NSOperation *operation;

@end

@implementation ViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    NSLog(@"warning!");
}

#pragma mark - Initialization

- (void) setup {
    
    [self initialProperties];
    [self initialTableContent];
    self.studentsContentArray = [self sortArray:self.studentsContentArray ByDescriptorVariant:sortByBirthDay];
    [self initialSectionsContentFromArray:self.studentsContentArray withSearchText:nil];
}

- (void) initialProperties {
    
    self.studentsContentArray = [[NSArray alloc] init];
    self.sectionsContentArray = [[NSArray alloc] init];
    self.sectionIndexArray = [[NSArray alloc] init];
}

- (void) initialTableContent {

    NSMutableArray *tempArray = [NSMutableArray array];

    for (int i = 0; i < 10000; i++) {

        MRQModelData *student = [MRQModelData initialWithRandomStudent];
        [tempArray addObject:student];
    }
    
    self.studentsContentArray = tempArray;
}

- (void) initialSectionsContentFromArray:(NSArray *) array withSearchText:(NSString *) searchText {
    
    NSString *curretString = nil;
    MRQModelData *section = nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM"];
    
    NSString *sectionIndexString = nil;
    NSMutableArray *sectionIndexArray = [NSMutableArray array];
    NSMutableArray *tempSectionArray = [NSMutableArray array];
    
    for (MRQModelData *item in array) {
        
        if ([searchText length] > 0) {
            if ([item.studentName rangeOfString:searchText].location == NSNotFound &&
                [item.studentLastName rangeOfString:searchText].location == NSNotFound) {
                continue;
            }
        }
        
        NSString *selectedString = nil;
        
        switch (self.segmentedControl.selectedSegmentIndex) {

            case sortByBirthDay: {
                selectedString = [dateFormatter stringFromDate:item.studentBirthDay];
                break;
            }
                
            case sortByName: {
                selectedString = [item.studentName substringToIndex:1];
                break;
            }
                
            case sortByLastName: {
                selectedString = [item.studentLastName substringToIndex:1];
                break;
            }
        }
        
        if (![selectedString isEqualToString:curretString]) {

            section = [[MRQModelData alloc] init];
            section.sectionName = selectedString;

            sectionIndexString = section.sectionName;
            [sectionIndexArray addObject:sectionIndexString];
            
            NSMutableArray *tempItemArray = [NSMutableArray array];
            
            [tempItemArray addObject:item];
            section.sectionArray = tempItemArray;
            
            [tempSectionArray addObject:section];
            
            curretString = selectedString;
            
        } else {
            
            NSMutableArray *tempArray = [NSMutableArray arrayWithArray:section.sectionArray];
            [tempArray addObject:item];
            section.sectionArray = tempArray;
        }
    }
    self.sectionIndexArray = sectionIndexArray;
    self.sectionsContentArray = tempSectionArray;
}

#pragma mark - Additional

- (NSArray *) sortArray:(NSArray *) array ByDescriptorVariant:(DescriptorVariant) variant {
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:array];
    
    NSSortDescriptor *sortByStudentName = [[NSSortDescriptor alloc] initWithKey:@"studentName" ascending:YES];
    NSSortDescriptor *sortByStudentLastName = [[NSSortDescriptor alloc] initWithKey:@"studentLastName" ascending:YES];
    NSSortDescriptor *sortByStudentBirthDay = [[NSSortDescriptor alloc] initWithKey:@"studentBirthDay" ascending:YES];
    
    array = [self sortArrayByBirthMonth:array];
    
    switch (variant) {
        case sortByBirthDay: {
            array = [tempArray sortedArrayUsingDescriptors:@[sortByStudentBirthDay, sortByStudentName, sortByStudentLastName]];
            array = [self sortArrayByBirthMonth:array];
            break;
        }
        case sortByName: {
            array = [tempArray sortedArrayUsingDescriptors:@[sortByStudentName, sortByStudentBirthDay, sortByStudentLastName]];
            break;
        }
        case sortByLastName: {
            array = [tempArray sortedArrayUsingDescriptors:@[sortByStudentLastName, sortByStudentBirthDay, sortByStudentName]];
            break;
        }
        default:
            break;
    }

    return array;
}

- (NSArray *) sortArrayByBirthMonth:(NSArray *) array {
 
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:array];
    
    [tempArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        NSInteger objOne = [obj1 getMonthByComponents];
        NSInteger objTwo = [obj2 getMonthByComponents];
        
        if (objOne < objTwo) {
            return NSOrderedAscending;
        } else if (objOne > objTwo) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    
    array = tempArray;
    
    return array;
}

- (void) initialTableContentInBackground {
    
    
}

#pragma mark - Actions

- (IBAction)actionSegmentedControlValueChanged:(UISegmentedControl *)sender {
    
    self.studentsContentArray = [self sortArray:self.studentsContentArray
                            ByDescriptorVariant:(DescriptorVariant)sender.selectedSegmentIndex];
    
    [self initialSectionsContentFromArray:self.studentsContentArray withSearchText:self.searchBar.text];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [[self.sectionsContentArray objectAtIndex:section] sectionName];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.sectionsContentArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    MRQModelData *mySection = [self.sectionsContentArray objectAtIndex:section];
    
    return [mySection.sectionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString* identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    MRQModelData *section = [self.sectionsContentArray objectAtIndex:indexPath.section];
    MRQModelData *item = [section.sectionArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", item.studentName, item.studentLastName];
    cell.detailTextLabel.text = [item setupDateFormatWithDate:item.studentBirthDay];
    
    return cell;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return self.sectionIndexArray;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [self initialSectionsContentFromArray:self.studentsContentArray withSearchText:searchText];
    NSLog(@"%@", searchText);
    [self.tableView reloadData];
}

@end
