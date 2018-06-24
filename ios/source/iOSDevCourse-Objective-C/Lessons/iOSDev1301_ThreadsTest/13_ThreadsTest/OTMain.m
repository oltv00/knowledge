//
//  OTMain.m
//  13_ThreadsTest
//
//  Created by Oleg Tverdokhleb on 06.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTMain.h"

@interface OTMain ()

@property (strong, nonatomic) NSMutableArray *array;

@end

@implementation OTMain

+ (OTMain *)sharedMain {
    static OTMain *main = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        main = [[OTMain alloc] init];
    });
    return main;
}

- (void)dealloc {
    NSLog(@"%@ is deallocated", self);
}

- (void)main {
//    [self one];
//    [self two];
//    [self three];
//    [self four];
//    [self five];
//    [self six];
    [self seven];
}

- (void)eigth {
    NSOperation *op = [[NSOperation alloc] init];
    NSOperationQueue *queue = 
}

- (void)seven {
    self.array = [NSMutableArray array];
    //DISPATCH_QUEUE_SERIAL - все по очереди
    //DISPATCH_QUEUE_CONCURRENT - одновременное
    dispatch_queue_t queue = dispatch_queue_create("com.oltv00.threadstest.queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{ //DISPATCH_QUEUE_PRIORITY_DEFAULT
        NSLog(@"O %@", [NSThread isMainThread] ? @"YES" : @"NO");
        [self addStringToArray:@"O"];
    });
    
    dispatch_async(queue, ^{ //DISPATCH_QUEUE_PRIORITY_DEFAULT
        NSLog(@"X %@", [NSThread isMainThread] ? @"YES" : @"NO");
        [self addStringToArray:@"X"];
    });
    
    [self performSelector:@selector(printArray) withObject:nil afterDelay:3.f];
}

- (void)six {
    self.array = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{ //DISPATCH_QUEUE_PRIORITY_DEFAULT
        NSLog(@"O %@", [NSThread isMainThread] ? @"YES" : @"NO");
        [self addStringToArray:@"O"];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ //DISPATCH_QUEUE_PRIORITY_DEFAULT
        NSLog(@"X %@", [NSThread isMainThread] ? @"YES" : @"NO");
        [self addStringToArray:@"X"];
    });
    
    [self performSelector:@selector(printArray) withObject:nil afterDelay:3.f];
}

- (void)five {
    //dispatch_queue_t queue - стек блоков
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"dispatch_get_global_queue %@", [NSThread isMainThread] ? @"YES" : @"NO");
        
        double startTime = CACurrentMediaTime();
        NSLog(@"%@ started", [[NSThread currentThread] name]);
        for (int i = 0; i < 20000000; i++) {
            //        NSLog(@"%d", i);
        }
        NSLog(@"%@ finished %f", [[NSThread currentThread] name], CACurrentMediaTime() - startTime);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"dispatch_get_main_queue %@", [NSThread isMainThread] ? @"YES" : @"NO");
        });
    });
    NSLog(@"five %@", [NSThread isMainThread] ? @"YES" : @"NO");
}

- (void)four {
    //LOCK
    self.array = [NSMutableArray array];
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self
                                                selector:@selector(addStringToArrayWithLock:) object:@"X"];
    
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self
                                                selector:@selector(addStringToArrayWithLock:) object:@"O"];
    
    thread1.name = @"Thread 1";
    thread2.name = @"Thread 2";
    
    [thread1 start];
    [thread2 start];
    
    [self performSelector:@selector(printArray) withObject:nil afterDelay:3.f];
}

- (void)addStringToArrayWithLock:(NSString *)string {
    double startTime = CACurrentMediaTime();
    NSLog(@"%@ started", [[NSThread currentThread] name]);

    @synchronized(self) {
        NSLog(@"%@ calculations started", [[NSThread currentThread] name]);
        for (int i = 0; i < 200000; i++) {
//            @synchronized (self) {
                [self.array addObject:string];
//            }
        }
        NSLog(@"%@ calculations ended", [[NSThread currentThread] name]);
    }

    NSLog(@"%@ finished %f", [[NSThread currentThread] name], CACurrentMediaTime() - startTime);
}

- (void)three {
    self.array = [NSMutableArray array];
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(addStringToArray:) object:@"X"];
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(addStringToArray:) object:@"O"];

    thread1.name = @"Thread 1";
    thread2.name = @"Thread 2";

    [thread1 start];
    [thread2 start];
    
    [self performSelector:@selector(printArray) withObject:nil afterDelay:3.f];
}

- (void)addStringToArray:(NSString *)string {
    double startTime = CACurrentMediaTime();
    NSLog(@"%@ started", [[NSThread currentThread] name]);
    for (int i = 0; i < 200000; i++) {
        [self.array addObject:string];
    }
    NSLog(@"%@ finished %f", [[NSThread currentThread] name], CACurrentMediaTime() - startTime);
}

- (void)printArray {
    NSLog(@"%@", self.array);
}

- (void)two {
//    NSLog(@"Is main thread? %@", [NSThread isMainThread] ? @"YES" : @"NO");
    for (int i = 0; i < 50; i++) {
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(thread) object:nil];
        thread.name = [NSString stringWithFormat:@"Thread #%d", i +1];
        [thread start];
    }
}

- (void)one {
    [self performSelectorInBackground:@selector(thread) withObject:nil];
}

- (void)thread {
    double startTime = CACurrentMediaTime();
    NSLog(@"%@ started", [[NSThread currentThread] name]);
    for (int i = 0; i < 20000000; i++) {
//        NSLog(@"%d", i);
    }
    NSLog(@"%@ finished %f", [[NSThread currentThread] name], CACurrentMediaTime() - startTime);
}

@end
