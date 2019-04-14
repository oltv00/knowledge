//
//  MRQStudent.m
//  41_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 29.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQStudent.h"

@implementation MRQStudent

// Insert code here to add functionality to your managed object subclass

- (BOOL)validateForDelete:(NSError **)error {
    
    NSLog(@"MRQStudent validateForDelete");
    
    return YES;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@ %@ %@", self.firstName, self.lastName, [self stringFromDate:self.dateOfBirth]];
}

- (NSString *) stringFromDate:(NSDate *) date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MMM.yyyy"];
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}
@end
