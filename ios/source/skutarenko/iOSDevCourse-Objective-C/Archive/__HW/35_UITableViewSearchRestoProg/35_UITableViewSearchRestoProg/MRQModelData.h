//
//  MRQStudent.h
//  35_UITableViewSearchRestoProg
//
//  Created by Oleg Tverdokhleb on 12.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRQModelData : NSObject

@property (strong, nonatomic) NSString *studentName;
@property (strong, nonatomic) NSString *studentLastName;
@property (strong, nonatomic) NSDate *studentBirthDay;

@property (strong, nonatomic) NSString *sectionName;
@property (strong, nonatomic) NSArray *sectionArray;

+ (MRQModelData *) initialWithRandomStudent;

- (NSString *) setupDateFormatWithDate:(NSDate *) date;
- (NSInteger) getMonthByComponents;

@end
