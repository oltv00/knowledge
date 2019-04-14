//
//  MSMStudent.m
//  SearchHomeWork
//
//  Created by Admin on 27.02.14.
//  Copyright (c) 2014 Sergey Monastyrskiy. All rights reserved.
//

#import "MSMStudent.h"
#import "MSMViewController.h"

@implementation MSMStudent

static NSString *firstName[] =  {
    @"Chan",        @"Wong",        @"Lau",             @"Cheng",       @"Chui",
    @"Fong",        @"Ho",          @"Cheung",          @"Lau",         @"Leung",
    @"Cheung",      @"Tsang",       @"Lai",             @"Lam",         @"Wong",
    @"Tsang",       @"Wong",        @"Chan",            @"Mak",         @"Ng",
    @"Lau",         @"Ng",          @"Pun",             @"Tang",        @"Cheung",
    @"Kwok",        @"Lai",         @"Wong",            @"Mak",         @"Yeung"
};

static NSString *lastName[] =   {
    @"Ngo Tin",     @"Yuk Lui",     @"Chi Sum",         @"Ka Fai",      @"Lok Chun",
    @"Wun Chi",     @"Ka Kam",      @"Tsz Ming",        @"Sin Yiu",     @"Kwan Hau",
    @"Shun Yiu",    @"Wing Sze",    @"So Pui",          @"Kin Lok",     @"Shun Yiu",
    @"Tsz Huen",    @"Ka Chun",     @"Fong Chuen",      @"Ka Chun",     @"Chun Yin",
    @"Wai Long",    @"Ka Ming",     @"Ming Shan",       @"Chi Ho",      @"Po Man",
    @"Chung",       @"Po Wing",     @"Po Yin Bonnie",   @"Yuk Ching",   @"Chue Hei"
};

+ (MSMStudent *)createNewStudent
{
    MSMStudent *student = [[MSMStudent alloc] init];
    student.firstName = firstName[arc4random() % studentsCount];
    student.lastName = lastName[arc4random() % studentsCount];    
    
    NSDate *dateCurrent             = [NSDate date];
    NSCalendar *calendar            = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    NSDateComponents *components    = [calendar components:NSCalendarUnitYear fromDate:dateCurrent];
    NSInteger yearCurrent           = [components year];
    NSInteger birthdateYear         = yearCurrent - (arc4random() % 25 + 18);
    NSInteger birthdateDay          = arc4random() % 31 + 1;
    NSInteger birthdateMonth        = arc4random() % 12 + 1;
    
    [components setDay:birthdateDay];
    [components setMonth:birthdateMonth];
    [components setYear:birthdateYear];
    student.birthdate               = [calendar dateFromComponents:components];
    student.birthdateMonth          = birthdateMonth;
    
    return student;
}

/*
- (void)defineMonthsList:(NSUInteger)month bySender:(MSMViewController *)viewController
{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %d", month];
    NSArray *monthsList = [viewController.sectionIndexesList filteredArrayUsingPredicate:predicate];
    
    if ([monthsList count] ==  0)
    {
        [viewController.sectionIndexesList addObject:[NSNumber numberWithInt:month]];
        NSMutableArray *studentsList = [NSMutableArray array];
        [studentsList addObject:self];
        [viewController.sectionRowsList addObject:studentsList];
    }
    
    else
    {
        NSInteger studentsListIndex = [viewController.sectionIndexesList indexOfObject:[NSNumber numberWithInt:month]];
        NSMutableArray *studentsList = [viewController.sectionRowsList objectAtIndex:studentsListIndex];
        [studentsList addObject:self];
        [viewController.sectionRowsList replaceObjectAtIndex:studentsListIndex withObject:studentsList];
    }
}
 */

@end
