//
//  MRQDataModel.m
//  31-32_UITableViewEditing_RestoProg
//
//  Created by Oleg Tverdokhleb on 29.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQDataModel.h"
#import "MRQStaticData.h"

@implementation MRQDataModel

+ (MRQDataModel *) initialGroupWithIndex:(NSInteger) index {
    
    MRQDataModel *group = [[MRQDataModel alloc] init];
    
    group.name = [NSString stringWithFormat:@"Group #%ld", index];
    
    return group;
}

+ (MRQDataModel *) initialStudent {
    
    MRQDataModel *student = [[MRQDataModel alloc] init];
    
    student.firstName = firstNames[arc4random() % studentsCount];
    student.lastName = lastNames[arc4random() % studentsCount];
    student.averageGrade = ((CGFloat)(arc4random() % 301) + 200) / 100;
    
    return student;
}

@end
