//
//  ViewController.m
//  30_UITableViewDynamicCells_HWRestoProg
//
//  Created by Oleg Tverdokhleb on 28.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import "MRQModelTestClass.h"
#import "MRQStudents.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *modelTestClassObjectsArray;
@property (strong, nonatomic) NSMutableArray *studentsArray;
@property (strong, nonatomic) NSArray *studentsSortedArray;

@property (strong, nonatomic) NSMutableArray *veryGoodStudents;
@property (strong, nonatomic) NSMutableArray *goodStudents;
@property (strong, nonatomic) NSMutableArray *badStudents;
@property (strong, nonatomic) NSMutableArray *veryBadStudents;

@end

@implementation ViewController

#pragma mark - DefVC methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Setups

- (void) initializes {

    self.modelTestClassObjectsArray = [NSMutableArray array];
    self.studentsArray              = [NSMutableArray array];
    self.studentsSortedArray        = [NSArray array];
    
    self.veryGoodStudents           = [NSMutableArray array];
    self.goodStudents               = [NSMutableArray array];
    self.badStudents                = [NSMutableArray array];
    self.veryBadStudents            = [NSMutableArray array];
    
    [self modelTestClassObjectsArray];

    [self studentsSetup];
    [self sortStudentsByAlphabetically];
    [self sortStudentsByPerfomance];
}

- (void) modelTestClassObjectsSetup {

    for (int i = 0; i < 1000; i++) {
        MRQModelTestClass *object = [[MRQModelTestClass alloc] init];
        [self.modelTestClassObjectsArray addObject:object];
    }
}

- (void) studentsSetup {
    
    for (int i = 0; i < 30; i++) {
        MRQStudents *student = [[MRQStudents alloc] init];
        [self.studentsArray addObject:student];
    }
}

- (void) sortStudentsByAlphabetically {
    
    NSArray *sortedArray = [self.studentsArray sortedArrayUsingComparator:
                                       ^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                                           
                                           if ([[obj1 lastName] compare:[obj2 lastName]] == NSOrderedAscending) {
                                               return NSOrderedAscending;
                                           }

                                           if ([[obj1 lastName] compare:[obj2 lastName]] == NSOrderedDescending) {
                                               return NSOrderedDescending;
                                           }
                                           
                                           return NSOrderedSame;
                                       }];
    self.studentsSortedArray = sortedArray;
}

- (void) sortStudentsByPerfomance {
    
    for (MRQStudents *student in self.studentsSortedArray) {
 
        switch (student.perfomance) {
            case MRQStudentsPerformanceVeryGood: {
                [self.veryGoodStudents addObject:student];
                break;
            }
            case MRQStudentsPerformanceGood: {
                [self.goodStudents addObject:student];
                break;
            }
            case MRQStudentsPerformanceBad: {
                [self.badStudents addObject:student];
                break;
            }
            case MRQStudentsPerformanceVeryBad: {
                [self.veryBadStudents addObject:student];
                break;
            }
            default:
                break;
        }
    }
}

#pragma mark - HW methods

- (UIColor *) generateRandomColor {
    
    CGFloat r = (float)(arc4random() % 256) / 255;
    CGFloat g = (float)(arc4random() % 256) / 255;
    CGFloat b = (float)(arc4random() % 256) / 255;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}

//Уровень "Ученик"
- (UITableViewCell *) displayCellWithColorMethod:(UITableViewCell *) aCell {
    
    UIColor *color = [self generateRandomColor];
    
    CGFloat r,g,b,a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    NSString *colorString = [NSString stringWithFormat:@"R.G.B { %1.f, %1.f, %1.f }", r * 255, g * 255, b * 255];
    
    aCell.textLabel.text = colorString;
    aCell.backgroundColor = [self generateRandomColor];
    aCell.textLabel.textColor = color;

    return aCell;
}

//Уровень "Студент"
- (UITableViewCell *) displayCellWithOtherClassMethod:(UITableViewCell *) aCell atIndex:(NSInteger) index{

    MRQModelTestClass *someObjectInOtherClass = [self.modelTestClassObjectsArray objectAtIndex:index];
    aCell.textLabel.text = [someObjectInOtherClass.name stringByAppendingString:[NSString stringWithFormat:@" and index: %ld", someObjectInOtherClass.index]];
    
    return aCell;
}

//Уровень - "Мастер" - "Супермен"
- (UITableViewCell *) displayCellWithStudent:(UITableViewCell *) aCell atRow:(NSInteger) row onSection:(NSInteger) section {
    
    MRQStudents *student;
    
    switch (section) {
        case veryGoodStudents: {
            student = [self.veryGoodStudents objectAtIndex:row];
            break;
        }
        case goodStudents: {
            student = [self.goodStudents objectAtIndex:row];
            break;
        }
        case badStudents: {
            student = [self.badStudents objectAtIndex:row];
            break;
        }
        case veryBadStudents: {
            student = [self.veryBadStudents objectAtIndex:row];
            break;
        }
        default:
            break;
    }

    aCell = [self displayCell:aCell byStudent:student];

    if (student.averageScore == 2) {
        aCell.textLabel.textColor = [UIColor redColor];
    } else {
        aCell.textLabel.textColor = [UIColor blackColor];
    }
    
    return aCell;
}

- (UITableViewCell *) displayCell:(UITableViewCell *) aCell byStudent:(MRQStudents *) student {

    aCell.textLabel.text        = [student.name stringByAppendingString:[NSString stringWithFormat:@" %@", student.lastName]];
    aCell.detailTextLabel.text  = [NSString stringWithFormat:@"%ld", student.averageScore];
    
    return aCell;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//    switch (section) {
//        case veryGoodStudents:
//            return [self.veryGoodStudents count];
//            break;
//        case goodStudents:
//            return [self.goodStudents count];
//            break;
//        case badStudents:
//            return [self.badStudents count];
//            break;
//        case veryBadStudents:
//            return [self.veryBadStudents count];
//            break;
//        default:
//            break;
//    }

    return 1000;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
//    switch (section) {
//        case veryGoodStudents:
//            return [NSString stringWithFormat:@"Very Good Students"];
//            break;
//        case goodStudents:
//            return [NSString stringWithFormat:@"Good Students"];
//            break;
//        case badStudents:
//            return [NSString stringWithFormat:@"Bad Students"];
//            break;
//        case veryBadStudents:
//            return [NSString stringWithFormat:@"Very Bad Students"];
//            break;
//        default:
//            break;
//    }
    
    return [NSString stringWithFormat:@"Colors"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"identifier";
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!aCell) {
        aCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        //NSLog(@"aCell is created");
    } else {
        //NSLog(@"aCell is reused");
    }
    
    //Вызов метода для уровня "Ученик" -
    [self displayCellWithColorMethod:aCell];
    //Вызов метода для уровня "Студен" - [self displayCellWithOtherClassMethod:aCell atIndex:indexPath.row];
    //Вызов метода для уровня "Супермен - "aCell = [self displayCellWithStudent:aCell atRow:indexPath.row onSection:indexPath.section];

    return aCell;
}

@end
