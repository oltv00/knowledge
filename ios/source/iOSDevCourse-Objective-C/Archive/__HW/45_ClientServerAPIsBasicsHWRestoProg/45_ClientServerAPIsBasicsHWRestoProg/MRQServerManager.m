//
//  MRQServerManager.m
//  45_ClientServerAPIsBasicsHWRestoProg
//
//  Created by Oleg Tverdokhleb on 17.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQServerManager.h"
#import "AFNetworking.h"

#import "MRQUser.h"
#import "MRQDetailedUser.h"
#import "MRQFollower.h"
#import "MRQSubscriptor.h"

@implementation MRQServerManager

#pragma mark - Singleton

+ (MRQServerManager*) sharedManager {
    
    static MRQServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MRQServerManager alloc] init];
    });
    
    return manager;
}

#pragma mark - API

-(void)getFriendsWithOffset:(NSInteger)offset
                      count:(NSInteger)count
                  onSuccess:(void (^)(NSArray *))success
                  onFailure:(void (^)(NSError *))failure
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"286385229",   @"user_id",
                                @"name",        @"order",
                                @(count),       @"count",
                                @(offset),      @"offset",
                                @"photo_100",   @"fields",
                                @"nom",         @"name_case",
                                @"5.8",         @"version", nil];
    
    [[AFHTTPSessionManager manager] GET:@"https://api.vk.com/method/friends.get"
                             parameters:parameters
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    NSLog(@"%@", responseObject);
                                    
                                    NSArray *dictsArray = [responseObject objectForKey:@"response"];

                                    NSMutableArray *objectsArray = [NSMutableArray array];
                                    for (NSDictionary *dict in dictsArray) {
                                        MRQUser *user = [[MRQUser alloc] initWithServerResponse:dict];
                                        [objectsArray addObject:user];
                                    }
                                    success(objectsArray);
                                }
                                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    NSLog(@"Error:%@", [error localizedDescription]);
                                    if (error) {
                                        failure(error);
                                    }
                                }];
}

-(void)getDetailedUserWithID:(NSInteger) userID
                   onSuccess:(void (^)(NSArray *))success
                   onFailure:(void (^)(NSError *))failure
{
    /*
     user_ids userID
     fields
     name_case nom
     */
    
    NSString *stringID = [NSString stringWithFormat:@"%ld", userID];
    
    NSDictionary *parameteres = [NSDictionary dictionaryWithObjectsAndKeys:
                                 stringID,  @"user_ids",
                                 @"photo_max, followers_count", @"fields",
                                 @"nom",    @"name_case",
                                 @"5.8",       @"version", nil];
    
    [[AFHTTPSessionManager manager] GET:@"https://api.vk.com/method/users.get"
                             parameters:parameteres
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    NSLog(@"%@", responseObject);
                                    
                                    NSArray *userInfo = [responseObject objectForKey:@"response"];
                                    NSMutableArray *resultArray = [NSMutableArray array];
                                    
                                    MRQDetailedUser *user = [[MRQDetailedUser alloc] initWithServerResponse:[userInfo firstObject]];
                                    [resultArray addObject:user];
                                    
                                    success(resultArray);
                                }
                                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    NSLog(@"%@", [error localizedDescription]);
                                    if (error) {
                                        failure(error);
                                    }
                                }];
}

-(void)getFollowersWithUserID:(NSInteger)userID
                       offset:(NSInteger)offset
                        count:(NSInteger)count
                    onSuccess:(void (^)(NSArray *, NSInteger))success
                    onFailure:(void (^)(NSError *))failure {
    
    NSString *stringID = [NSString stringWithFormat:@"%ld", userID];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                stringID,       @"user_id",
                                @(offset),      @"offset",
                                @(count),       @"count",
                                @"nom",         @"name_case",
                                
                                @"first_name,"
                                "last_name,"
                                "photo_50",     @"fields", nil];
    
    [[AFHTTPSessionManager manager] GET:@"https://api.vk.com/method/users.getFollowers"
                             parameters:parameters
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    NSLog(@"%@", responseObject);
                                    
                                    NSDictionary *dicts = [responseObject objectForKey:@"response"];
                                    NSArray *items      = [dicts objectForKey:@"items"];
                                    NSNumber *count     = [dicts objectForKey:@"count"];
                                    
                                    NSMutableArray *resultArray = [NSMutableArray array];
                                    for (NSDictionary *dict in items) {
                                        MRQFollower *follower = [[MRQFollower alloc] initWithServerResponse:dict];
                                        [resultArray addObject:follower];
                                    }
                                    
                                    success(resultArray, [count integerValue]);
                                }
                                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    NSLog(@"%@", [error localizedDescription]);
                                }];
}

-(void)getSubscriptionsWithUserID:(NSInteger)userID
                           offset:(NSInteger)offset
                            count:(NSInteger)count
                        onSuccess:(void (^)(NSArray *, NSInteger))success
                        onFailure:(void (^)(NSError *))failure
{
    NSString *stringID = [NSString stringWithFormat:@"%ld", userID];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                stringID,       @"user_id",
                                @"1",           @"extended",
                                @(offset),      @"offset",
                                @(count),       @"count",
                                @"photo_50,"
                                "first_name,"
                                "last_name, id",  @"fields", nil];
    
    [[AFHTTPSessionManager manager] GET:@"https://api.vk.com/method/users.getSubscriptions"
                             parameters:parameters
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    NSLog(@"%@", responseObject);
                                    
                                    NSMutableArray *resultArray = [NSMutableArray array];
                                    
                                    NSArray *subs = [responseObject objectForKey:@"response"];
                                    
                                    for (NSDictionary *dict in subs) {
                                        
                                        NSString *type = [dict objectForKey:@"type"];
                                        if ([type isEqualToString:@"profile"]) {
                                            
                                            MRQSubscriptor *sub = [[MRQSubscriptor alloc] initWithServerResponse:dict];
                                            [resultArray addObject:sub];
                                            
                                        } else {
                                            
                                        #warning need page object and parsing

                                        }
                                    }
                                    
                                    success(resultArray, 5);
                                }
                                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    NSLog(@"%@", [error localizedDescription]);
                                    failure(error);
                                }];
}

-(void)getWallWithUserID:(NSInteger)userID
                  offset:(NSInteger)offset
                   count:(NSInteger)count
               onSuccess:(void (^)(NSArray *))success
               onFailure:(void (^)(NSError *))failure
{
    NSString *stringID = [NSString stringWithFormat:@"%ld", userID];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                stringID,   @"owner_id",
                                (offset),   @"offset",
                                (count),    @"count",
                                @"all",     @"filter",
                                @"5.37",    @"v", nil];
    
    [[AFHTTPSessionManager manager] GET:@"https://api.vk.com/method/wall.get"
                             parameters:parameters
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    NSLog(@"%@", responseObject);
                                    
                                }
                                failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    NSLog(@"%@", [error localizedDescription]);
                                    failure(error);
                                }];
}

@end
