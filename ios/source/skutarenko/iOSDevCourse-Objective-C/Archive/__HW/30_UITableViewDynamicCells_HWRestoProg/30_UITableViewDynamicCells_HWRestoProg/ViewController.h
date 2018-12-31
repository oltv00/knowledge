//
//  ViewController.h
//  30_UITableViewDynamicCells_HWRestoProg
//
//  Created by Oleg Tverdokhleb on 28.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    veryGoodStudents,
    goodStudents,
    badStudents,
    veryBadStudents,
    
} displaySectionByPerfomance;

@interface ViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

