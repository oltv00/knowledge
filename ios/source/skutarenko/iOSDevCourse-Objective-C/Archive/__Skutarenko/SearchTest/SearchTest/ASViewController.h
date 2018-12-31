//
//  ASViewController.h
//  SearchTest
//
//  Created by Oleksii Skutarenko on 03.01.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASViewController : UITableViewController <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar* searchBar;

@end
