//
//  ViewController.m
//  30_UITableViewDynamicCells_FontsTest
//
//  Created by Oleg Tverdokhleb on 26.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSLog(@"numberOfSectionsInTableView");
    
    return [[UIFont familyNames] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"numberOfRowsInSection: %ld", section);
    
    NSArray *familyNames = [UIFont familyNames];
    
    NSString *fontName = [familyNames objectAtIndex:section];
    
    NSArray *fontNames = [UIFont  fontNamesForFamilyName:fontName];
    
    return [fontNames count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //return [NSString stringWithFormat:@"Section: %ld", section];

    NSArray *familyNames = [UIFont familyNames];
    
    NSString *fontName = [familyNames objectAtIndex:section];
    
    return fontName;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cellForRowAtIndexPath: {%ld, %ld}", indexPath.section, indexPath.row);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifierCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifierCell"];
        NSLog(@"Cell is created");
    } else {
        NSLog(@"Cell is reused");
    }
    
    NSArray *familyNames = [UIFont familyNames];
    
    NSString *familyName = [familyNames objectAtIndex:indexPath.section];
    
    NSArray* fontNames = [UIFont fontNamesForFamilyName:familyName];
    
    NSString *fontName = [fontNames objectAtIndex:indexPath.row];

    UIFont *font = [UIFont fontWithName:fontName size:16];
    
    cell.textLabel.text = fontName;
    cell.textLabel.font = font;

    return  cell;
}

@end
