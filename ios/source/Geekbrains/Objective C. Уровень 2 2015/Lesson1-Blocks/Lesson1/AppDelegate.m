//
//  AppDelegate.m
//  Lesson1
//
//  Created by Oleg Tverdokhleb on 10.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "AppDelegate.h"
#import "Block.h"

typedef BOOL (^Equals)(NSString *, NSString *);
typedef void (^BlockedBlock)(void);

@interface AppDelegate ()

@property (weak, nonatomic) Equals equals;
@property (weak, nonatomic) BlockedBlock myBlock;
@property (strong,nonatomic) NSMutableArray *array;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    Block *blk = [[Block alloc] init];
    
    // Override point for customization after application launch.
    
    void (^block)(void) = ^(void) {
        NSLog(@"block");
    };
    
    block();
    
    NSArray *blockArray = [NSArray arrayWithObject:block];
    NSLog(@"%@", blockArray);
    
    int (^myBlock)(int) = ^(int num) {
        return num;
    };
    
    NSString *(^testBlock)(NSString *, NSInteger) = ^(NSString *one, NSInteger two) {return one;};
    
    BOOL (^equals)(NSString *, NSString *) = ^(NSString *first, NSString *second){
        
        BOOL isEquals;
        
        if ([first isEqualToString:second]) {
            isEquals = YES;
        } else {
            isEquals = NO;
        }
        
        return isEquals;
    };
    self.equals = equals;
    NSString *str1 = @"eqr";
    NSString *str2 = @"eqr";
    if (equals(str1, str2)) {
        NSLog(@"YES");
    } else {
        NSLog(@"NO");
    }
    
//    NSMutableArray *array = [NSMutableArray array];
//    //self.array = array;
//    for (int i = 0; i < 100000000; i++) {
//        [array addObject:@(i)];
//    }
    
    void(^blockedBlock)(void) = ^(void){
//        NSLog(@"%@", [array objectAtIndex:45]);
    };
    
    self.myBlock = blockedBlock;
    
    return YES;
}

- (IBAction) actionProcess:(id)sender {
    [self process:self.myBlock];
}

- (void) process:(void(^)(void)) block {
    block();
}

- (void)isEquals:(BOOL(^)(NSString* first, NSString *second)) equals {
    
}

- (void)dealloc {
    NSLog(@"%@ is deallocated", self);
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
