//
//  ViewController.m
//  Lesson4
//
//  Created by Oleg Tverdokhleb on 20.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //выполнение кода в параллельном потоке
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //выполнение кода в главном потоке
        });
    });
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        //код который необходимо выполнить в главном потоке
        //ждем окончания выполнения
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
}

- (void)threadsStart {
    for (int i = 0; i < 50; i++) {
        NSThread *thread = [[NSThread alloc]
                            initWithTarget:self
                            selector:@selector(threadsCode)
                            object:nil];
        thread.name = [NSString stringWithFormat:@"Thread #%i", i + 1];
        [thread start];
    }
}

- (void)threadsCode {
    double startTime = CACurrentMediaTime();
    NSLog(@"%@ started", [NSThread currentThread].name);
    for (int i = 0; i < 20000000; i++) {
        NSLog(@"calculation in thread %@", [NSThread currentThread].name);
    }
    NSLog(@"%@ finished in %f", [NSThread currentThread].name, CACurrentMediaTime() - startTime);
}

- (void)setArray {
    for (int i = 0; i < 20000; i++) {
        NSLog(@"%i", i);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
