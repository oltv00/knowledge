//
//  AppDelegate.m
//  16_TimeTest
//
//  Created by Oleg Tverdokhleb on 25.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "AppDelegate.h"
#import "MRQObject.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*
    NSDate *date = [NSDate date];
    
    NSLog(@"%@", date);
    
    NSLog(@"%@", [date dateByAddingTimeInterval:5000]);
    NSLog(@"%@", [date dateByAddingTimeInterval:-5000]);
    
    NSLog(@"%d", [date compare:[date dateByAddingTimeInterval:-5000]]); // Сравнение дат.
    
    NSLog(@"%@",[date earlierDate:[date dateByAddingTimeInterval:-5000]]); // Выводит более ранюю дату.
    
    NSDate *date2 = [NSDate dateWithTimeIntervalSinceReferenceDate:10];
    NSLog(@"%@", date2);
    */
    
    /*
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    NSLog(@"%@", [dateFormatter stringFromDate:date]);
    
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    NSLog(@"%@", [dateFormatter stringFromDate:date]);

    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSLog(@"%@", [dateFormatter stringFromDate:date]);
    
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    NSLog(@"%@", [dateFormatter stringFromDate:date]);
    
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    NSLog(@"%@", [dateFormatter stringFromDate:date]);

    [dateFormatter setDateFormat:@"M MM MMM MMMM MMMMM"];
    NSLog(@"%@", [dateFormatter stringFromDate:date]);
    
    [dateFormatter setDateFormat:@"D DD DDD DDDD DDDDD"];
    NSLog(@"%@", [dateFormatter stringFromDate:date]);
    
    [dateFormatter setDateFormat:@"yyyy/MM/dd E EE EEE EEEE EEEEE"];
    NSLog(@"%@", [dateFormatter stringFromDate:date]);
    
    [dateFormatter setDateFormat:@"yyyy/MM/dd H HH HHH HHHH HHHHH h hh hhh hhhh hhhhh"];
    NSLog(@"%@", [dateFormatter stringFromDate:date]);
    
    [dateFormatter setDateFormat:@"yyyy/MM/dd EEEE HH:mm:s a w W"];
    NSLog(@"%@", [dateFormatter stringFromDate:date]);
    */ // Форматирование даты!
    
    /*
    NSDate *date = [[NSDate alloc] init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSLog(@"%@", [dateFormatter stringFromDate:date]);
    
    NSDate *date2 = [dateFormatter dateFromString:@"2008/05/17 15:37"];
    NSLog(@"%@", date2);
    */
    
    /*
    NSDate *date = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:    NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
                                                            NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    
    NSLog(@"%@", components);
    */ // Date Components! Вывод год месяц день часы минуты секунды.
    
    /*
    NSDate *date1 = [NSDate date];
    NSDate *date2 = [NSDate dateWithTimeIntervalSinceNow:-1000000];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute
                                               fromDate:date2 toDate:date1 options:0];
    NSLog(@"%@", components);
    */ // Интервал между датами date1 и date2;
    
    /*
    //Таймер!
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerTest:) userInfo:nil repeats:YES];
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:5]]; // Запуск таймера через 5 секунд.
    
    //<#(NSTimeInterval)#> - через сколько будет вызван таймер
    //target - тот кто будет вызван
    //selector - метод который вызывается
    //userInfo - (id) любой объект который передается и будет частью этого таймера, у таймера есть свойство userInfo (обычно передается NSDictionary)
    //repeats - Повторяется через каждые <#(NSTimeInterval)#>
    
    //Таймер никогда не уничтожается! Уничтожается в ручную. [timer invalidate];
    */ //Тоже самое что и в классе MRQObject!
    
    MRQObject* obj = [[MRQObject alloc] init];

    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
