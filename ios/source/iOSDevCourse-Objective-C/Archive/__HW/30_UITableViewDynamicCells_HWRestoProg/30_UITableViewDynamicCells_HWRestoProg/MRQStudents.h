//
//  MRQStudents.h
//  30_UITableViewDynamicCells_HWRestoProg
//
//  Created by Oleg Tverdokhleb on 28.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    MRQStudentsPerformanceVeryGood  = 5,
    MRQStudentsPerformanceGood      = 4,
    MRQStudentsPerformanceBad       = 3,
    MRQStudentsPerformanceVeryBad   = 2
    
} MRQStudentsPerformance;

@interface MRQStudents : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) NSInteger averageScore;
@property (assign, nonatomic) MRQStudentsPerformance perfomance;

@end
