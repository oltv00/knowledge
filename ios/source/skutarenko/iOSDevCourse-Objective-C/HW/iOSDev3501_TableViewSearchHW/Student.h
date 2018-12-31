//
//  Student.h
//  iOSDev3501_TableViewSearchHW
//
//  Created by Oleg Tverdokhleb on 01.05.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastname;
@property (strong, nonatomic) NSDate *birthday;

@property (assign, nonatomic) NSRange nameRange;
@property (assign, nonatomic) NSRange lastnameRange;

+ (NSArray *)initializeStudentsCount:(NSInteger)count;
- (NSString *)stringFromDate:(NSDate *)date;
- (NSInteger)getMonth:(NSDate *)date;

@end
