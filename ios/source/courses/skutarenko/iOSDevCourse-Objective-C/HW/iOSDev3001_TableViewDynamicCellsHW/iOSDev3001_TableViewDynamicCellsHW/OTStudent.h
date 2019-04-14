//
//  OTStudent.h
//  iOSDev3001_TableViewDynamicCellsHW
//
//  Created by Oleg Tverdokhleb on 24.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTStudent : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastname;
@property (assign, nonatomic) double averageScore;

+ (NSArray *)initStudentsWithCount:(NSInteger)count;

@end
