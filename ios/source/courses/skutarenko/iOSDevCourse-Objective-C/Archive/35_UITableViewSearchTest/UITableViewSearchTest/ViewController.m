//
//  ViewController.m
//  UITableViewSearchTest
//
//  Created by Oleg Tverdokhleb on 09.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Random.h"
#import "MRQSections.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *content;
@property (strong, nonatomic) NSArray *sections;

@property (strong, nonatomic) NSOperation *currentOperation;

@end

@implementation ViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Additional

- (void) setup {

    [self initProperties];
    [self setupContentArray];
}

- (void) initProperties {
    
    self.content = [NSArray array];
    self.sections = [NSArray array];
}

- (void) setupContentArray {
    
    NSMutableArray *tempArray = [NSMutableArray array];
        
    for (int i = 0; i < 100; i ++) {
        
        NSString *string = [NSString randomAlphanumericString];
        string = [string capitalizedString];
        
        [tempArray addObject:string];
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
    [tempArray sortUsingDescriptors:@[sortDescriptor]];
    
    self.content = tempArray;
    
    //self.sections = [self generateSectionsFromArray:self.content withFilter:self.searchBar.text];
    [self generateSectionsFromArrayInBackgroundFromArray:self.content withFilter:self.searchBar.text];
}

- (void) generateSectionsFromArrayInBackgroundFromArray:(NSArray *) array withFilter:(NSString *) filterString {
    
    [self.currentOperation cancel];
    
    __weak ViewController *weakSelf = self;
    
    self.currentOperation = [NSBlockOperation blockOperationWithBlock:^{
       
        NSArray *sectionsArray = [weakSelf generateSectionsFromArray:self.content withFilter:filterString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.sections = sectionsArray;
            [weakSelf.tableView reloadData];
            
            self.currentOperation = nil;
        });
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:self.currentOperation];
}

- (NSArray *) generateSectionsFromArray:(NSArray *) array withFilter:(NSString *) filterString  {
    
    NSMutableArray *sectionsArray = [NSMutableArray array];
    NSString *curretLetter = nil;
    
    for (NSString *string in array) {
    
        if ([filterString length] > 0 && [string rangeOfString:filterString].location == NSNotFound) {
            continue;
        }
        
        NSString *firstLetter = [string substringToIndex:1];
        MRQSections *section = nil;
        
        if (![curretLetter isEqualToString:firstLetter]) {
            
            section = [[MRQSections alloc] init];
            section.name = firstLetter;
            curretLetter = firstLetter;
            section.items = [NSMutableArray array];
            [sectionsArray addObject:section];
        } else {
            section = [sectionsArray lastObject];
        }
        
        [section.items addObject:string];
    }
    
    return sectionsArray;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.sections count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [[self.sections objectAtIndex:section] name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    MRQSections *mySection = [self.sections objectAtIndex:section];

    return [mySection.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    MRQSections *section = [self.sections objectAtIndex:indexPath.section];
    
    cell.textLabel.text = [section.items objectAtIndex:indexPath.row];
    
    return cell;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *array = [NSMutableArray array];
    for (MRQSections *section in self.sections) {
        [array addObject:section.name];
    }
    return array;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

//    self.sections = [self generateSectionsFromArray:self.content withFilter:searchText];
//    [self.tableView reloadData];
    
    [self generateSectionsFromArrayInBackgroundFromArray:self.content withFilter:self.searchBar.text];
    [self.tableView reloadData];
    
    
}

@end
