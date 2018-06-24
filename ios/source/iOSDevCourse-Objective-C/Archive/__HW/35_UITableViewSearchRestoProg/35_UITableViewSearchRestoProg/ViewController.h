//
//  ViewController.h
//  35_UITableViewSearchRestoProg
//
//  Created by Oleg Tverdokhleb on 12.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong, nonatomic) NSArray *studentsContentArray;
@property (strong, nonatomic) NSArray *sectionsContentArray;

- (IBAction)actionSegmentedControlValueChanged:(UISegmentedControl *)sender;

@end
