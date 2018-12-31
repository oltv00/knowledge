//
//  MRQStudent.m
//  35_UITableViewSearchRestoProg
//
//  Created by Oleg Tverdokhleb on 12.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQModelData.h"

@implementation MRQModelData

+ (MRQModelData *) initialWithRandomStudent {
    
    MRQModelData *student = [[MRQModelData alloc] init];
    
    student.studentName = firstNames[arc4random() % itemsCount];
    student.studentLastName = lastNames[arc4random() % itemsCount];
    student.studentBirthDay = [student generateBirthDate];
    
    return student;
}

- (NSDate *) generateBirthDate {
    
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:date];
    NSInteger birthYear = [components year] - (arc4random() % 35 + 16);
    
    [components setDay:arc4random() % 32];
    [components setMonth:arc4random() % 13];
    [components setYear:birthYear];

    date = [calendar dateFromComponents:components];
    
    return date;
}

- (NSString *) setupDateFormatWithDate:(NSDate *) date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MMM.yyyy"];
    return [dateFormatter stringFromDate:date];
}

- (NSInteger) getMonthByComponents {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self.studentBirthDay];

    return [components month];
}

- (NSString *) description {
    
    return [NSString stringWithFormat:@"%@ %@ %@", self.studentName, self.studentLastName, self.studentBirthDay];
}

static int itemsCount = 50;

static NSString* firstNames[] = {
    
    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie"
};

static NSString* lastNames[] = {
    
    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
    @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
    @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
    @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook"
};

@end
