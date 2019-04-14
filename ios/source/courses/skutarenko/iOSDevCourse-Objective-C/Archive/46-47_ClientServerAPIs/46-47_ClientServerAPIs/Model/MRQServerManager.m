//
//  MRQServerManager.m
//  46-47_ClientServerAPIs
//
//  Created by Oleg Tverdokhleb on 24.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQServerManager.h"
#import "AFNetworking.h"
#import "MRQAccessToken.h"
#import "MRQUser.h"

#import "MRQLoginViewController.h"

@interface MRQServerManager()

@property (strong, nonatomic) MRQAccessToken *token;

@end

@implementation MRQServerManager

+ (MRQServerManager *)sharedManager {
    
    static MRQServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MRQServerManager alloc] init];
    });
    
    return manager;
}

- (void)authorizeUser:(void (^)(MRQUser *))completion {
    
    MRQLoginViewController *vc = [[MRQLoginViewController alloc] initWithCompletionBlock:^(MRQAccessToken *token) {
        
        self.token = token;
        
        if (token) {
            
            [self getUser:self.token.userID
                onSuccess:^(MRQUser *user) {
                    if (completion) {
                        completion(user);
                    }
                }
                onFailure:^(NSError *error) {
                    if (completion) {
                        completion(nil);
                    }
                }];
        }
    }];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    UIViewController *mainVC = [[[[UIApplication sharedApplication] windows] firstObject] rootViewController];
    [mainVC presentViewController:nc
                         animated:YES
                       completion:nil];
}

- (void)getUser:(NSString *)userID
      onSuccess:(void (^)(MRQUser *))success
      onFailure:(void (^)(NSError *))failure
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            userID,         @"user_ids",
                            @"photo_200",   @"fields",
                            @"nom",         @"name_case", nil];
    
    [[AFHTTPSessionManager manager]
     GET:@"https://api.vk.com/method/users.get"
     parameters:params
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSLog(@"%@", responseObject);
         
         NSArray *resultArray = [responseObject objectForKey:@"response"];
         NSDictionary *resultDict = [resultArray firstObject];
         
         MRQUser *user = [[MRQUser alloc] initWithServerResponseObject:resultDict];
         if (success) {
             success(user);
         }
     }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"%@", [error localizedDescription]);
         if (failure) {
             failure(error);
         }
     }];
}

@end
