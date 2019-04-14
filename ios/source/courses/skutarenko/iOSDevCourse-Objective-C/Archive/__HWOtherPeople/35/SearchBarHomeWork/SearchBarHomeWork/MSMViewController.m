//
//  MSMViewController.m
//  SearchBarHomeWork
//
//  Created by Admin on 05.03.14.
//  Copyright (c) 2014 Sergey Monastyrskiy. All rights reserved.
//

#import "MSMViewController.h"
#import "MSMSection.h"
#import "MSMStudent.h"

CGFloat sectionHeaderHeight = 44.f;
CGFloat titleOffset = 40.f;


@interface MSMViewController () <UISearchBarDelegate>

@property (strong, nonatomic) MSMStudent *student;
@property (strong, nonatomic) NSMutableArray *studentsArray;
@property (strong, nonatomic) MSMSection *section;
@property (strong, nonatomic) NSArray *sectionsArray;
@property (assign, nonatomic) NSInteger selectedScope;
@property (strong, nonatomic) NSString *searchString;
@property (strong, nonatomic) NSOperation *currentOperation;
@property (assign, nonatomic) NSInteger currentIndex;

@end


@implementation MSMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.studentsArray = [NSMutableArray array];
    self.sectionsArray = [NSArray array];
    self.selectedScope = 0;
    self.searchString = nil;
    self.currentIndex = 0;
    self.homeBarButton.enabled = NO;
    
    for (NSInteger iStudent = 0; iStudent < 2000; iStudent++)
    {
        [self.studentsArray addObject:[MSMStudent createNewStudent]];
    }
    
    [self generateSectionsInBackgroundFromArray:self.studentsArray];
    
    NSLog(@"viewDidLoad started...");
}


#pragma mark - Private methods -
- (void)generateSectionsInBackgroundFromArray:(NSArray *)array
{
    [self.currentOperation cancel];
    __weak MSMViewController *weakSelf = self;
    
    self.currentOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSArray *sectionsArray = [weakSelf generateSectionsFromArray:array];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            weakSelf.sectionsArray = sectionsArray;
            [weakSelf.tableView reloadData];
            self.currentOperation = nil;
        
        });
    }];
    
    [self.currentOperation start];
}

- (NSArray *)generateSectionsFromArray:(NSArray *)array
{
    NSMutableArray *sectionsArray = [NSMutableArray array];
    NSMutableArray *sectionsNameArray = [NSMutableArray array];
    
    for (MSMStudent *student in array)
    {
        MSMSection *section = [[MSMSection alloc] init];
        NSString *studentSearchText;
        NSString *sectionIndex;
        
        switch (self.selectedScope)
        {
            case 0:
            {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"dd.MM.yyyy"];
                studentSearchText = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:student.birthdate]];
                sectionIndex = (student.birthdateMonth > 9) ? [NSString stringWithFormat:@"%d", student.birthdateMonth] :
                                                              [NSString stringWithFormat:@"0%d", student.birthdateMonth];
            }
                break;
                
            case 1:
                studentSearchText = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
                sectionIndex = [studentSearchText substringToIndex:1];
                break;

            case 2:
                studentSearchText = [NSString stringWithFormat:@"%@ %@", student.lastName, student.firstName];
                sectionIndex = [studentSearchText substringToIndex:1];
                break;
        }
                
        if ([self.searchString length] > 0 && [studentSearchText rangeOfString:self.searchString].location == NSNotFound)
        {
            continue;
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF isEqual:%@", sectionIndex];
        NSArray *sectionsFilteredArray = [sectionsNameArray filteredArrayUsingPredicate:predicate];
        
        if ([sectionsFilteredArray count] ==  0)
        {
            section.index = sectionIndex;
            section.rowsArray = [NSMutableArray array];
            [section.rowsArray addObject:student];
            [sectionsArray addObject:section];
            [sectionsNameArray addObject:sectionIndex];
        }
        
        else
        {
            NSInteger indexSection = [sectionsNameArray indexOfObject:sectionIndex];
            section = [sectionsArray objectAtIndex:indexSection];
            [section.rowsArray addObject:student];
        }
    }

    return sectionsArray = [self sortingSectionsAndRows:sectionsArray];
}

- (NSMutableArray *)sortingSectionsAndRows:(NSMutableArray *)array
{
    NSSortDescriptor *sortByIndex   = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    [array sortUsingDescriptors:[NSArray arrayWithObjects:sortByIndex, nil]];

    for (MSMSection *section in array)
    {
        NSMutableArray *sectionRowsArray    = [[NSMutableArray alloc] init];
        [sectionRowsArray addObjectsFromArray:section.rowsArray];
        
        NSSortDescriptor *sortByBirthdate   = [NSSortDescriptor sortDescriptorWithKey:@"birthdate" ascending:YES];
        NSSortDescriptor *sortByFirstName   = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES];
        NSSortDescriptor *sortByLastName    = [NSSortDescriptor sortDescriptorWithKey:@"lastName"  ascending:YES];
        
        switch (self.selectedScope)
        {
            case 0:
                [sectionRowsArray sortUsingDescriptors:[NSArray arrayWithObjects:sortByBirthdate, sortByFirstName, sortByLastName, nil]];
                break;
                
            case 1:
                [sectionRowsArray sortUsingDescriptors:[NSArray arrayWithObjects:sortByFirstName, sortByLastName, sortByBirthdate, nil]];
                break;

            case 2:
                [sectionRowsArray sortUsingDescriptors:[NSArray arrayWithObjects:sortByLastName, sortByBirthdate, sortByFirstName, nil]];
                break;
        }

        section.rowsArray = sectionRowsArray;
    }
    
    return array;
}


#pragma mark - UITableViewDataSource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberOfSectionsInTableView = %d started...", [self.sectionsArray count]);
    return [self.sectionsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.navigationItem.title = @"Students List";
    self.section = [self.sectionsArray objectAtIndex:section];
    
    NSLog(@"in section = %d students numberOfRowsInSection = %d  started...", section, [self.section.rowsArray count]);
    return [self.section.rowsArray count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *sectionsTitlesList = [NSMutableArray array];
    
    for (MSMSection *section in self.sectionsArray)
    {
        [sectionsTitlesList addObject:section.index];
    }
    
    NSLog(@"sectionIndexTitlesForTableView = %@", sectionsTitlesList);
    return sectionsTitlesList;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    UILabel *titleLabel = [[UILabel alloc] init];

    if (self.selectedScope == 0)
    {
        NSArray *namesList = [NSArray arrayWithObjects:   @"January",   @"February",    @"March",
                                                          @"April",     @"May",         @"June",
                                                          @"July",      @"August",      @"September",
                                                          @"October",   @"November",    @"December", nil];
        
        titleLabel.text = [NSString stringWithFormat:@"In %@ born %d students",
                           [namesList objectAtIndex:section], [[[self.sectionsArray objectAtIndex:section] rowsArray] count]];
    }
    
    else
    {
        titleLabel.text = [NSString stringWithFormat:@"Group letter \"%@\" include %d students",
                           [[self.sectionsArray objectAtIndex:section] index], [[[self.sectionsArray objectAtIndex:section] rowsArray] count]];
    }
    
    return titleLabel.text;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    self.section = [self.sectionsArray objectAtIndex:indexPath.section];
    NSMutableArray *studentsList = [NSMutableArray array];
    [studentsList addObjectsFromArray:self.section.rowsArray];
    self.student = [studentsList objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    if (self.selectedScope == 2)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", self.student.lastName, self.student.firstName];
    }
    
    else
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", self.student.firstName, self.student.lastName];
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:self.student.birthdate]];
    
    NSLog(@"cellForRowAtIndexPath (%d, %d) started...", indexPath.section, indexPath.row);
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    self.currentIndex = index;
    self.homeBarButton.enabled = (index > 0) ? YES : NO;
    
    NSLog(@"index = %d", index);
    return index;
}


#pragma mark - UISearchBarDelegate -
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchString = searchText;
    [self generateSectionsInBackgroundFromArray:self.studentsArray];
    
    NSLog(@"searchString = %@", searchText);
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    self.selectedScope = selectedScope;
    [self generateSectionsInBackgroundFromArray:self.studentsArray];
    
    NSLog(@"selectedScope = %d", self.selectedScope);
}


#pragma mark - Actions -
- (IBAction)actionClickHomeButton:(UIBarButtonItem *)sender
{
    self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top);

    NSLog(@"actionClickHomeButton started...");
}

- (IBAction)actionClickTopButton:(UIBarButtonItem *)sender
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    NSLog(@"actionClickTopButton started...");
}
@end
