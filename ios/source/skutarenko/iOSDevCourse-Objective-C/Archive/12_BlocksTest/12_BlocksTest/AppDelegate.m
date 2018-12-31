//
//  AppDelegate.m
//  12_BlocksTest
//
//  Created by Oleg Tverdokhleb on 23.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "AppDelegate.h"
#import "MRQObject.h"

typedef void (^OurTestBlock)(void);

@interface AppDelegate ()

@property (copy, nonatomic) OurTestBlock testBlock;
@property (strong, nonatomic) NSString *name;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //[self testMethod];
    
    void (^testBlock)(void);
    
    testBlock = ^{
        NSLog(@"test block");
    };
    
    testBlock();
    
    //-------------
    
    [self testMethodWithParams:@"TEST STRING" value:111];
    
    void (^testBlockWithParams)(NSString*,NSInteger) = ^(NSString* string, NSInteger iVal){
        NSLog(@"Test block with params: %@ %d", string, iVal);
    };
    
    testBlockWithParams(@"TEST STRING", 111);
    
    //---------------
    
    NSString* result = [self testMethodWithReturnValueAndParams:@"TEST STRING" value:123];
    
    NSLog(@"%@", result);
    
    //------------------
    
    NSString* (^testBlockWithReturnValueAndParams)(NSString*, NSInteger) = ^(NSString* string, NSInteger iVal) {
        return [NSString stringWithFormat:@"testBlockWithReturnValueAndParams: %@, %d", string, iVal];
    };
    
    result = testBlockWithReturnValueAndParams(@"TEST STRING", 111);
    
    NSLog(@"%@", result);

    //------------------------
    
    
    __block NSString* testString = @"How is it possible";
    
    __block NSInteger i = 0;
    
    void (^testBlockTwo)(void);
    
    testBlockTwo = ^{
        NSLog(@"Test block");
        testString = [NSString stringWithFormat:@"How is it possible? %d", ++i];
        NSLog(@"%@", testString);
    };
    
    testBlockTwo();
    testBlockTwo();
    testBlockTwo();
    testBlockTwo();
    testBlockTwo();
    
    //-------------------------------------------------
    
    void(^ccc)(void);
    
    ccc = ^{
        NSLog(@"BLOCK_CCC!!!");
    };
    
    [self testBlocksMethod:ccc];
    
    
    [self testBlocksMethod:^{
        NSLog(@"BLOCK!!!");
    }];
    
    //-------------------------------------------------
    
    OurTestBlock testBlock2 = ^{
        NSLog(@"BLOCK2 Typedef");
    };
    
    [self testBlockMethod2:testBlock2];
    
    //---------------------------------
    
    MRQObject *obj = [[MRQObject alloc] init];
    
    obj.name = @"OBJECT";
    
    __weak MRQObject *weakObj = obj;
    
    self.testBlock = ^ {
        NSLog(@"%@", obj.name);
    };

    self.testBlock = ^ {
        NSLog(@"%@", weakObj.name);
    };
    
    self.testBlock();
    
    //------------------------
    self.name = @"Hello!";
    
    MRQObject *objTwo  = [[MRQObject alloc] init];
    objTwo.name = @"OBJEEEEEEEECT";
    
    [objTwo testMethod:^{
        NSLog(@"%@", self.name);
    }];
    
    //------------------------------------------
    
    
    
    return YES;
}

- (void) testBlockMethod2:(OurTestBlock) testBlock {
    NSLog(@"testBlockMethod2:");
    
}

- (void) testBlocksMethod:(void (^)(void)) block {
    
    NSLog(@"testBlockMethod");
    
    block();
}


- (NSString*) testMethodWithReturnValueAndParams:(NSString*) string value:(NSInteger) intValue {
    return [NSString stringWithFormat:@"testMethodWithReturnValueAndParams %@ %d", string, intValue];
}


- (void) testMethodWithParams:(NSString*) string value:(NSInteger) intValue {
    NSLog(@"Test method with params: %@ %d", string, intValue);
}

- (void) testMethod {
    NSLog(@"test method!");
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
