//
//  OLTVAPIServerManager.m
//  iOSDev4501_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 04/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVAPIServerManager.h"

//Libs
#import "AFNetworking.h"

//Model
#import "../Model/OLTVUser.h"
#import "../Model/OLTVDetailedUser.h"
#import "../Model/OLTVGroup.h"
#import "../Model/OLTVWall.h"

@implementation OLTVAPIServerManager

+ (OLTVAPIServerManager *)sharedManager {
  static OLTVAPIServerManager *manager = nil;
  static dispatch_once_t token;
  dispatch_once(&token, ^{
    manager = [OLTVAPIServerManager new];
  });
  return manager;
}

- (void)getFriendsWithOffset:(NSInteger)offset
                       count:(NSInteger)count
                   onSuccess:(void(^)(NSArray *friends))success
                   onFailure:(void(^)(NSError *error))failure
{
  NSDictionary *parameters = @{
                               @"user_id"   : @"286385229",
                               @"order"     : @"name",
                               @"count"     : @(count),
                               @"offset"    : @(offset),
                               @"fields"    : @"photo_50",
                               @"name_case" : @"nom",
                               @"v"         : @"5.52"
                               };
  
  [[AFHTTPSessionManager manager]
   GET:@"https://api.vk.com/method/friends.get"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //NSLog(@"responseObject = %@", responseObject);
     NSDictionary *response = responseObject[@"response"];
     NSArray *items = response[@"items"];
     
     NSMutableArray *users = [NSMutableArray array];
     for (NSDictionary *item in items) {
       OLTVUser *user = [[OLTVUser alloc] initWithResponseObject:item];
       [users addObject:user];
     }
     
     if (success) {
       success(users);
     }
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (failure) {
       failure(error);
     }
   }];
}

- (void)getUserWithID:(NSString *)userID
            onSuccess:(void(^)(OLTVDetailedUser *user))success
            onFailure:(void(^)(NSError *error))failure
{
  
  NSDictionary *parameters = @{
                               @"user_ids"  : userID,
                               @"fields"    : @"photo_max_orig",
                               @"name_case" : @"Nom",
                               @"v"         : @"5.52"
                               };
  
  [[AFHTTPSessionManager manager]
   GET:@"https://api.vk.com/method/users.get"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //NSLog(@"responseObject = %@", responseObject);
     NSArray *response = responseObject[@"response"];
     NSDictionary *dict = [response firstObject];
     OLTVDetailedUser *detailedUser = [[OLTVDetailedUser alloc] initWithResponseObject:dict];
     
     if (success) {
       success(detailedUser);
     }
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (failure) {
       failure(error);
     }
   }];
}

- (void)getSubscriptionsWithUserID:(NSString *)userID
                            offset:(NSInteger)offset
                             count:(NSInteger)count
                         onSuccess:(void(^)(NSArray *users, NSArray *groups))success
                         onFailure:(void(^)(NSError *error))failure
{
  NSDictionary *parameters = @{
                               @"user_id"  : userID,
                               @"extended" : @"1",
                               @"offset"   : @(offset),
                               @"count"    : @(count),
                               @"fields"   : @"photo_50",
                               @"v"        : @"5.52"
                               };
  
  [[AFHTTPSessionManager manager]
   GET:@"https://api.vk.com/method/users.getSubscriptions"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //NSLog(@"responseObject = %@", responseObject);
     NSDictionary *response = responseObject[@"response"];
     NSArray *items = response[@"items"];
     
     NSMutableArray *users = [NSMutableArray array];
     NSMutableArray *groups = [NSMutableArray array];
     
     for (NSDictionary *item in items) {
       
       if ([item[@"type"] isEqualToString:@"profile"]) {
         
         OLTVUser *user = [[OLTVUser alloc] initWithResponseObject:item];
         [users addObject:user];
         
       } else if ([item[@"type"] isEqualToString:@"page"]) {
       
         OLTVGroup *group = [[OLTVGroup alloc] initWithResponseObject:item];
         [groups addObject:group];
         
       }
     }
     
     if (success) {
       success(users, groups);
     }
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (failure) {
       failure(error);
     }
   }];
}

- (void)getFollowersWithUserID:(NSString *)userID
                        offset:(NSInteger)offset
                         count:(NSInteger)count
                     onSuccess:(void(^)(NSArray *users))success
                     onFailure:(void(^)(NSError *error))failure
{
  NSDictionary *parameters = @{
                               @"user_id"   : userID,
                               @"offset"    : @(offset),
                               @"count"     : @(count),
                               @"fields"    : @"photo_50",
                               @"name_case" : @"nom",
                               @"v"   : @"5.52"
                               };
  
  [[AFHTTPSessionManager manager]
   GET:@"https://api.vk.com/method/users.getFollowers"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     NSLog(@"responseObject = %@", responseObject);
     NSDictionary *response = responseObject[@"response"];
     NSArray *items = response[@"items"];
     NSMutableArray *users = [NSMutableArray array];
     for (NSDictionary *item in items) {
       OLTVUser *user = [[OLTVUser alloc] initWithResponseObject:item];
       [users addObject:user];
     }
     if (success) {
       success(users);
     }
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (failure) {
       failure(error);
     }
   }];
}

- (void)getWallWithUserID:(NSString *)userID
                   offset:(NSInteger)offset
                    count:(NSInteger)count
                onSuccess:(void(^)(NSArray *wall))success
                onFailure:(void(^)(NSError *error))failure
{
  NSDictionary *parameters = @{
                               @"owner_id"  : userID,
                               @"offset"    : @(offset),
                               @"count"     : @(count),
                               @"extended"  : @"0",
                               @"filter"    : @"owner",
                               @"v"   : @"5.52"
                               };
  
  [[AFHTTPSessionManager manager]
   GET:@"https://api.vk.com/method/wall.get"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //NSLog(@"responseObject = %@", responseObject);
     
     NSDictionary *response = responseObject[@"response"];
     NSArray *items = response[@"items"];
     
     NSMutableArray *resultArray = [NSMutableArray array];
     for (id item in items) {
       NSLog(@"%@", item);
       
       if ([item isKindOfClass:[NSDictionary class]]) {
         OLTVWall *wall = [[OLTVWall alloc] initWithResponseObject:item];
         [resultArray addObject:wall];
       }
     }
     
     if (success) {
       success(resultArray);
     }
     
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (failure) {
       failure(error);
     }
   }];
}

@end
