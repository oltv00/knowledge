//
//  OLTVServerManager.m
//  iOSDev4501_APITest
//
//  Created by Oleg Tverdokhleb on 02/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVServerManager.h"

//Libs
#import "AFNetworking.h"

//Model
#import "OLTVUser.h"
#import "OLTVAccessToken.h"

//Controller
#import "OLTVLoginViewController.h"

@interface OLTVServerManager ()
@property (strong, nonatomic) OLTVAccessToken *accessToken;
@end

@implementation OLTVServerManager

+ (OLTVServerManager *)sharedManager {  
  static OLTVServerManager *manager = nil;
  static dispatch_once_t token;
  dispatch_once(&token, ^{
    manager = [OLTVServerManager new];
  });
  return manager;
}

- (void)authorizeUser:(void(^)(OLTVUser *user))completion {
  OLTVLoginViewController *vc = [[OLTVLoginViewController alloc] initWithCompletionBlock:^(OLTVAccessToken *token) {
    self.accessToken = token;
    
    if (completion) {
      completion(nil);
    }
  }];
  
  UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
  UIViewController *mainVC = [UIApplication sharedApplication].keyWindow.rootViewController;
  [mainVC presentViewController:nc animated:YES completion:nil];
}

- (void)getFriendsWithOffset:(NSInteger)offset
                       count:(NSInteger)count
                   onSuccess:(void(^)(NSArray *friends))success
                   onFailure:(void(^)(NSError *error, NSInteger statusCode))failure
{
  NSDictionary *params = @{
                           @"user_id"   : @"286385229",
                           @"order"     : @"name",
                           @"count"     : @(count),
                           @"offset"    : @(offset),
                           @"fields"    : @"photo_50",
                           @"name_case" : @"nom",
                           @"version"   : @"5.52"
                           };
  
  [[AFHTTPSessionManager manager]
   GET:@"https://api.vk.com/method/friends.get"
   parameters:params
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     NSLog(@"%@", responseObject);

     NSArray *dicts = responseObject[@"response"];
     NSMutableArray *users = [NSMutableArray array];
     
     for (NSDictionary *dict in dicts) {
       OLTVUser *user = [[OLTVUser alloc] initWithResponseObject:dict];
       [users addObject:user];
     }
     
     if (success) {
       success(users);
     }
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (failure) {
       failure(error, 111);
     }
   }];
}

@end
