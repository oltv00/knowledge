//
//  RBServerManager.m
//  Home Work - Server API
//
//  Created by Roman Bogomolov on 13/10/14.
//  Copyright (c) 2014 Roman Bogomolov. All rights reserved.
//

#import "RBServerManager.h"
#import "AFNetworking.h"
#import "RBUser.h"
#import "RBUserWall.h"

@interface RBServerManager ()

@property (strong, nonatomic) AFHTTPRequestOperationManager* requestOperationManager;
@property (strong , nonatomic) RBUser* user;
@end

@implementation RBServerManager


+ (RBServerManager*) sharedManager {
    
    static RBServerManager* manager = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RBServerManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSURL* url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    }
    return self;
}

- (void) gerFriendsFromServerWithOffset:(NSInteger) offset
                                  count:(NSInteger) count
                              onSuccess:(void(^)(NSArray* friends)) success
                              onFailure:(void(^)(NSError* error)) failure {
    
    NSDictionary* parametrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"232964790",        @"user_id",
                               @"name",             @"order",
                               @(count),            @"count",
                               @(offset),           @"offset",
                               @"photo_100, online", @"fields",
                               @"nom",              @"name_case", nil];
    
    [self.requestOperationManager
     
      GET:@"friends.get"
      parameters:parametrs
      success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
          
          NSArray* dictionaryArray = [responseObject objectForKey:@"response"];
          
          NSMutableArray* objectsArray = [NSMutableArray array];
          
          for (NSDictionary* object in dictionaryArray) {
              RBUser* user = [[RBUser alloc] initWithServerResponse:object];
              
              [objectsArray addObject:user];
          }
          
          if (success) {
              success(objectsArray);
          }
             
      //  NSLog(@"JSON: %@", responseObject);
          
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

- (void) getUsers_ids:(NSString*) userID
            onSuccess:(void(^)(RBUser* user)) success
            onFailure:(void(^)(NSError* error)) failure {
    
    NSDictionary* parametrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               userID,                                       @"user_ids",
                               @"photo_100, online, city, country, online",  @"fields",
                               @"nom",                                       @"name_case", nil];
    
    [self.requestOperationManager
    
    
     GET:@"users.get"
     parameters:parametrs
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSArray* dictionaryArray = [responseObject objectForKey:@"response"];
         
         RBUser* user = [[RBUser alloc] initWithServerResponse:[dictionaryArray firstObject]];

         if (success) {
             success(user);
         }

         
         //NSLog(@"JSON: %@", responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"Error: %@", error);
         
     }];
    
}

- (void) getFollowers:(NSString*) userID
           withOffset:(NSInteger) offset
                count:(NSInteger) count
            onSuccess:(void(^)(NSArray* followersArray)) success
            onFailure:(void(^)(NSError* error)) failure {
    
    
    NSDictionary* parametrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               userID,                  @"user_id",
                               @(offset),               @"offset",
                               @(count),                @"count",
                               @"photo_100, online",    @"fields", nil];
    
    
    [self.requestOperationManager
     
     GET:@"users.getFollowers"
     parameters:parametrs
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         
         NSArray *dictionaryArray = [[responseObject objectForKey:@"response"] objectForKey:@"items"];
         
         NSMutableArray* array = [NSMutableArray array];
         
         for (NSDictionary* object in dictionaryArray) {
             
             RBUser* follower = [[RBUser alloc] initWithServerResponse:object];
             
             [array addObject:follower];
         }
         
         //NSLog(@"JSON: %@", array);
         
         success(array);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"Error: %@", error);
         
     }];
 
}

- (void) getSubscribers:(NSString*) userID
             withOffset:(NSInteger) offset
                  count:(NSInteger) count
              onSuccess:(void(^)(NSArray* subscribersArray)) success
              onFailure:(void(^)(NSError* error)) failure {
    
    NSDictionary* parametrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               userID,              @"user_id",
                               @(offset),           @"offset",
                               @(count),            @"count",
                               @"photo_100",        @"fields",
                               @"1",                @"extended", nil];
    
    [self.requestOperationManager
     
     GET:@"users.getSubscriptions"
     parameters:parametrs
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         
         NSArray *dictionaryArray = [responseObject objectForKey:@"response"];
         
         NSMutableArray* array = [NSMutableArray array];
         
         for (NSDictionary* objects in dictionaryArray) {
             
             RBUser* sub = [[RBUser alloc] initWithServerResponse:objects];
             
             [array addObject:sub];
         }
         
         
         success(array);

     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"Error: %@", error);
         
     }];

    
    
}

- (void) getCitiesById:(NSString*) cityID
            onSuccess:(void(^)(NSString* city)) success
            onFailure:(void(^)(NSError* error)) failure {
    
     NSDictionary* parametrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               cityID, @"city_ids", nil];
    
     [self.requestOperationManager
     
     GET:@"database.getCitiesById"
     parameters:parametrs
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         
         NSArray *dictionaryArray = [responseObject objectForKey:@"response"];
         
         NSString* city = [[dictionaryArray firstObject] objectForKey:@"name"];
     
         success(city);
 
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"Error: %@", error);
         
     }];
    
}

- (void) getCountriesById:(NSString*) countryID
             onSuccess:(void(^)(NSString* country)) success
             onFailure:(void(^)(NSError* error)) failure {
    
    NSDictionary* parametrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               countryID, @"country_ids", nil];
    
    [self.requestOperationManager
     
     GET:@"database.getCountriesById"
     parameters:parametrs
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         
         NSArray *dictionaryArray = [responseObject objectForKey:@"response"];
         
         NSString* country = [[dictionaryArray firstObject] objectForKey:@"name"];
         
         success(country);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"Error: %@", error);
         
     }];
    
}


- (void) getUserWall:(NSString*) userID
          withOffset:(NSInteger) offset
               count:(NSInteger) count
           onSuccess:(void(^)(NSArray* wallArray)) success
           onFailure:(void(^)(NSError* error)) failure {
    
    NSDictionary* parametrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               userID,                              @"owner_id",
                               @(count),                            @"count",
                               @(offset),                           @"offset",
                               @"owner",                            @"filter", nil];
    
    [self.requestOperationManager
     
     
     GET:@"wall.get"
     parameters:parametrs
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSArray* dictionaryArray = [responseObject objectForKey:@"response"];
         
         if ([dictionaryArray count] > 1) {
             dictionaryArray = [dictionaryArray subarrayWithRange:NSMakeRange(1, [dictionaryArray count] - 1)];
         } else {
             
             dictionaryArray = nil;
         }
         
         NSMutableArray* array = [NSMutableArray array];
         
         for (NSDictionary* object in dictionaryArray) {
             
             RBUserWall* user = [[RBUserWall alloc] initWithServerResponse:object];
             
             [array addObject:user];
             
         }
         
         success(array);
         
         
       //  NSLog(@"JSON: %@", dictionaryArray);
         
         
            
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"Error: %@", error);
         
     }];

}

@end
