//
//  MRQStudents.m
//  30_UITableViewDynamicCells_HWRestoProg
//
//  Created by Oleg Tverdokhleb on 28.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQStudents.h"

@interface MRQStudents ()

@property (strong, nonatomic) NSArray *studentsNames;
@property (strong, nonatomic) NSArray *studentsLastNames;

@end

@implementation MRQStudents

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _name           = [self generateStudentNameAtIndex];
        _lastName       = [self generateStudentLastNameAtIndex];
        _averageScore   = [self generateRandomAverageScore];
        _perfomance     = (int)_averageScore;
    }
    
    return self;
}

- (NSInteger) generateRandomAverageScore {

    NSInteger score = arc4random() % 7;
    switch (score) {
        case 0: {
            score += 2;
            break;
        }
        case 1: {
            score += 1;
            break;
        }
        case 6: {
            score -= 1;
            break;
        }
        case 7: {
            score -= 2;
            break;
        }
        default:
            break;
    }
    
    return score;
}

- (NSString *) generateStudentNameAtIndex {

    //ОЧЕНЬ ПЛОХО ТАК ДЕЛАТЬ
    self.studentsNames      = @[@"Иван", @"Сергей", @"Олег", @"Татьяна", @"Алена", @"Егор", @"Николай",
                                @"Парамон", @"Демид", @"Карп", @"Ульян", @"Захар", @"Вероника", @"Изот", @"Розалия",
                                @"Конкордия", @"Федосий", @"Эмилия", @"Лада", @"Любомир", @"Варвара", @"Николай", @"Тимур"];
    
    NSInteger studentNameIndex = arc4random() % ([self.studentsNames count] - 1);
    
    return [self.studentsNames objectAtIndex:studentNameIndex];
}

- (NSString *) generateStudentLastNameAtIndex {
    
    //ОЧЕНЬ ПЛОХО ТАК ДЕЛАТЬ
    self.studentsLastNames  = @[@"Крылова", @"Игнатьева", @"Павлов", @"Зайцева", @"Прокофьева", @"Баранов", @"Комаров",
                                @"Муравьев", @"Воробьёва", @"Андреев", @"Пешнин", @"Городнов", @"Макарова", @"Захаров",
                                @"Львова", @"Щербакова", @"Морозов", @"Маркова", @"Захаров", @"Борисова", @"Лебедева",
                                @"Журавель", @"Кудрявцев"];

    NSInteger studentLastNameIndex = arc4random() % ([self.studentsLastNames count] - 1);

    return [self.studentsLastNames objectAtIndex:studentLastNameIndex];
}

@end
