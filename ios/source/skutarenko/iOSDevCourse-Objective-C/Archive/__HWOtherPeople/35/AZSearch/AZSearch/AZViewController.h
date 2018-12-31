//
//  AZViewController.h
//  AZSearch
//
//  Created by Alex Alexandrov on 12.02.14.
//  Copyright (c) 2014 Alex Zbirnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AZViewController : UIViewController

typedef enum{
    
    AZSortDescrptionBirthDay,
    AZSortDescrptionFirstName,
    AZSortDescrptionLastName
    
} AZSortDescrption;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;



- (IBAction)actionValueChangeSigmentedControl:(UISegmentedControl *)sender;

@end
