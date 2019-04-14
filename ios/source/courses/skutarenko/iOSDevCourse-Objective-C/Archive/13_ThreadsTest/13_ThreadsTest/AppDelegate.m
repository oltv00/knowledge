//
//  AppDelegate.m
//  13_ThreadsTest
//
//  Created by Oleg Tverdokhleb on 24.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong, nonatomic) NSMutableArray *array;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [self performSelectorInBackground:@selector(testThread) withObject:nil];
  
    //[[NSThread currentThread] isMainThread]; - узнать на каком потоке мы сейчас. Возвращает типа BOOL;
    
    /*
    for (int i = 0; i < 50; i++){
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(testThread) object:nil];
        thread.name = [NSString stringWithFormat:@"Thread #%d", i + 1];
        [thread start];
    }
    */
    
    //-------------------------------
    
    /*
    self.array = [NSMutableArray array];
    
    NSThread *threadOne = [[NSThread alloc] initWithTarget:self selector:@selector(addStringToArray:) object:@"X"];
    NSThread *threadTwo = [[NSThread alloc] initWithTarget:self selector:@selector(addStringToArray:) object:@"0"];
    
    threadOne.name = @"Thread One";
    threadTwo.name = @"Thread Two";

    [threadOne start];
    [threadTwo start];
    
    [self performSelector:@selector(printArray) withObject:nil afterDelay:3];
    */
    
    //GRAND CENTRAL DISPATCH - !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    /*
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        
        double startTime = CACurrentMediaTime();
        
        NSLog(@"%@ started", [[NSThread currentThread] name]);
        
        for (int i = 0; i < 20000000; i++){
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@ finished in %f", [[NSThread currentThread] name], CACurrentMediaTime() - startTime);
        
            //[self performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#>]
            
        });
        
    });
    */

    self.array = [NSMutableArray array];
    
    //dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_queue_t queue = dispatch_queue_create("com.mrqresto.testthreads.queue", DISPATCH_QUEUE_SERIAL);
    
    __weak id weakSelf = self;
    
    dispatch_async(queue, ^{
        [weakSelf addStringToArray:@"X"];
    });

    dispatch_async(queue, ^{
        [weakSelf addStringToArray:@"0"];
    });
    
    dispatch_async(queue, ^{
       dispatch_async(dispatch_get_main_queue(), ^{
          // UI refresh;
       });
    });
    
    NSOperation *operation;
    NSOperationQueue *operationQueue;
    
    [self performSelector:@selector(printArray) withObject:nil afterDelay:3];
    
    return YES;
}

- (void) printArray {
    NSLog(@"%@", self.array);
}

- (void) addStringToArray:(NSString*) string{
    @autoreleasepool {
        
        double startTime = CACurrentMediaTime();
        NSLog(@"%@ started", [[NSThread currentThread] name]);
        
//        @synchronized(self) {
            
            NSLog(@"%@ calculations started", [[NSThread currentThread] name]);
            
            for (int i = 0; i < 200000; i++){
                //@synchronized - можно поставить туда, тогда запись будет хаотичная но не будет потерь.
                [self.array addObject:string];
            }
            
            NSLog(@"%@ calculations ended", [[NSThread currentThread] name]);
        
//        }
        
        NSLog(@"%@ finished in %f", [[NSThread currentThread] name], CACurrentMediaTime() - startTime);
    }
}

- (void) testThread {
    @autoreleasepool { // возможно не обязательно.
        
        double startTime = CACurrentMediaTime();
        
        NSLog(@"%@ started", [[NSThread currentThread] name]);
        
        for (int i = 0; i < 20000000; i++){
            //NSLog(@"%d", i);
        }
        
        NSLog(@"%@ finished in %f", [[NSThread currentThread] name], CACurrentMediaTime() - startTime);
    
    }
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
