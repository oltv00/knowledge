//
//  NBPopoverDatePicker.m
//  Lesson36-HOmeWork
//
//  Created by Nick Bibikov on 1/15/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import "NBPopoverDatePicker.h"
#import "CSAnimation.h"

@interface NBPopoverDatePicker ()

@property (strong, nonatomic) NSDate* lastDateFromPicker;

@end

@implementation NBPopoverDatePicker

- (void) viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)datePickerAction:(UIDatePicker *)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    self.lastDateFromPicker = sender.date;
    
    NSString *stringFromDate = [dateFormatter stringFromDate:sender.date];
    
    [self.delegate NBPopoverDatePicker:self dateBirth:stringFromDate howOldAreYou:[self howOldAreYou:sender.date]];

}


- (NSString*) howOldAreYou:(NSDate*) birtday {
    
    NSCalendar* calendar      = [NSCalendar currentCalendar];
    unsigned unitFlag         = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear;
    NSString* result          = [NSString new];

    NSDateComponents* ageCalc = [calendar components:unitFlag fromDate:birtday toDate:[NSDate date] options:0];

    NSInteger month           = [ageCalc month];
    NSInteger days            = [ageCalc day];
    NSInteger years           = [ageCalc year];
    
    if (month < 0 || days < 0 || years < 0) {
        result = @"Not Born Yet";
        
    } else if (month == 0 && days == 0 && years == 0) {
        result = @"Born Today!";
        
    } else {
        result = [NSString stringWithFormat:@"%li yr %li mn %li dy old", (long)years, (long)month, (long)days];
        
    }
    
    return result;
}

@end
