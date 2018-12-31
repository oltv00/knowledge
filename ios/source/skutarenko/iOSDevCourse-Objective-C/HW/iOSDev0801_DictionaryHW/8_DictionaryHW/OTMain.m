//
//  OTMain.m
//  8_DictionaryHW
//
//  Created by Oleg Tverdokhleb on 01.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTMain.h"
#import "OTStudent.h"

@implementation OTMain

- (void)main {
//    [self levelNoob];
//    [self levelStudent];
    [self levelMaster];
}

- (void)levelMaster {
    NSMutableArray *arrayOfStudents = [NSMutableArray array];
    NSMutableArray *arrayOfKeys = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        OTStudent *student = [[OTStudent alloc] init];
        [arrayOfStudents addObject:student];
        
        NSString *key = [NSString stringWithFormat:@"%@%@", student.name, student.lastName];
        [arrayOfKeys addObject:key];
    }
    
    NSDictionary *journal = [NSDictionary dictionaryWithObjects:arrayOfStudents forKeys:arrayOfKeys];
    
    NSArray *sortedArrayOfKeys = [arrayOfKeys sortedArrayUsingSelector:@selector(compare:)];
    
    for (NSString *key in sortedArrayOfKeys) {
        id object = journal[key];
        if (![object isKindOfClass:[OTStudent class]]) {
            NSLog(@"WARNING!!! OBJECT IS NOT STUDENT CLASS");
        } else {
            OTStudent *student = (OTStudent *)object;
            [student greeting];
        }
    }
}

- (void)levelStudent {
    NSMutableArray *arrayOfStudents = [NSMutableArray array];
    NSMutableArray *arrayOfKeys = [NSMutableArray array];
    for (int i = 0; i < 15; i++) {
        OTStudent *student = [[OTStudent alloc] init];
        [arrayOfStudents addObject:student];
        
        NSString *key = [NSString stringWithFormat:@"%@%@", student.name, student.lastName];
        [arrayOfKeys addObject:key];
    }
    
    NSDictionary *journal = [NSDictionary dictionaryWithObjects:arrayOfStudents forKeys:arrayOfKeys];
    
    for (NSString *key in [journal allKeys]) {
        id object = journal[key];
        if (![object isKindOfClass:[OTStudent class]]) {
            NSLog(@"WARNING!!! OBJECT IS NOT STUDENT CLASS");
        } else {
            OTStudent *student = (OTStudent *)object;
            [student greeting];
        }
    }
}

- (void)levelNoob {
    NSMutableArray *arrayOfStudents = [NSMutableArray array];
    NSMutableArray *arrayOfKeys = [NSMutableArray array];
    for (int i = 0; i < 15; i++) {
        OTStudent *student = [[OTStudent alloc] init];
        [arrayOfStudents addObject:student];
        
        NSString *key = [NSString stringWithFormat:@"%@%@", student.name, student.lastName];
        [arrayOfKeys addObject:key];
    }
    NSDictionary *journal = [NSDictionary dictionaryWithObjects:arrayOfStudents forKeys:arrayOfKeys];
    NSLog(@"%@", journal);
}

@end
