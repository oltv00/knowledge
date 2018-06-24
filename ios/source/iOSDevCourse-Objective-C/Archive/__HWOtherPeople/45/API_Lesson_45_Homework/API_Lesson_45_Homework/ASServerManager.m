//
//  ASServerManager.m
//  API_Lesson_45_Homework
//
//

#import "ASServerManager.h"
#import "AFNetworking.h"
#import "ASUser.h"
#import "ASUserPage.h"
#import "ASSubscriber.h"
#import "ASFollower.h"


@implementation ASServerManager


+(ASServerManager*) sharedManager {
    static ASServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ASServerManager alloc] init];
    });
    
    return manager;
}


-(void) getFriendsWithOffset: (NSInteger) offset
                       count: (NSInteger) count
                   onSuccess: (void (^) (NSArray* friends)) success
                   onFailure: (void (^) (NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"41812715",    @"user_id",
                            @"name",      @"order",
                            @(count),       @"count",
                            @(offset),      @"offset",
                            @"photo_50,online",    @"fields",
                            @"nom",         @"name_case",nil];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"https://api.vk.com/method/friends.get"
      parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
          
        //NSLog(@"JSON: %@", responseObject);
          
        NSArray* dictArray = [responseObject objectForKey:@"response"];
          
        NSMutableArray* objectsArray = [NSMutableArray array];
        
          for (NSDictionary* dict in dictArray) {
              ASUser* user = [[ASUser alloc] initWithServerResponse:dict];
              [objectsArray addObject:user];
          }
          
        if (success) {
            success(objectsArray);
        }
             
             
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        if (failure) {
            failure(error, operation.response.statusCode);
        }
        
    }]; 
}




-(void) getUserPageWithID: (NSInteger) userID
                onSuccess: (void (^) (NSArray* userData)) success
                onFailure: (void (^) (NSError* error, NSInteger statusCode)) failure {
    
    NSString* idString = [NSString stringWithFormat:@"%ld", userID];
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            idString,                               @"user_ids",
                            @"photo_100,city,online,bdate,counters",         @"fields",
                            @"nom",                                 @"name_case", nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://api.vk.com/method/users.get" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //NSLog(@"JSON: %@", responseObject);
        
        NSDictionary* dictArray = [responseObject objectForKey:@"response"];
        
        NSMutableArray* objectsArray = [NSMutableArray array];
        
        for (NSDictionary* dict in dictArray) {
            ASUserPage* user = [[ASUserPage alloc] initWithServerResponse:dict];
            [objectsArray addObject:user];
        }
        
        if (success) {
            success(objectsArray);
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        if (failure) {
            failure(error, operation.response.statusCode);
        }
        
    }];

}




-(void) getSubscriberOfUserWithID: (NSInteger) userID
                           offset: (NSInteger) offset
                            count: (NSInteger) count
                        onSuccess: (void (^) (NSArray* subscribers, NSInteger count)) success
                        onFailure: (void (^) (NSError* error, NSInteger statusCode)) failure {
    
    NSString* stringID = [NSString stringWithFormat:@"%ld", userID];
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            stringID,       @"user_id",
                            @"1",           @"extended",
                            @(count),          @"count",
                            @(offset),      @"offset",
                            @"5.37",        @"v",nil];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"https://api.vk.com/method/users.getSubscriptions"
      parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
          
          NSDictionary* tempDict = [responseObject objectForKey:@"response"];
          
          NSArray* dictArray = [tempDict objectForKey:@"items"];
          
          NSString* countOfSub = [tempDict objectForKey:@"count"];
          
          NSLog(@"================================ count %@", countOfSub);
          
          //NSLog(@"users.getSubscriptions JSON: %@", dictArray);
          
          NSMutableArray* objectsArray = [NSMutableArray array];
          
          for (NSDictionary* dict in dictArray) {
              ASSubscriber* subscriber = [[ASSubscriber alloc] initWithServerResponse:dict];
              [objectsArray addObject:subscriber];
          }
                    
          if (success) {
              success(objectsArray, (int)[countOfSub integerValue]);
          }
          
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
          NSLog(@"Error: %@", error);
          
          if (failure) {
              failure(error, operation.response.statusCode);
          }
          
      }]; 
}


-(void) getFollowersOfUserWithID: (NSInteger) userID
                           offset: (NSInteger) offset
                            count: (NSInteger) count
                        onSuccess: (void (^) (NSArray* followers, NSInteger count)) success
                        onFailure: (void (^) (NSError* error, NSInteger statusCode)) failure {
    
    NSString* stringID = [NSString stringWithFormat:@"%ld", userID];
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            stringID,       @"user_id",
                            @"photo_50",    @"fields",
                            @(count),       @"count",
                            @(offset),      @"offset",
                            @"5.37",        @"v",nil];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"https://api.vk.com/method/users.getFollowers"
      parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
          
          NSDictionary* tempDict = [responseObject objectForKey:@"response"];
          
          NSArray* dictArray = [tempDict objectForKey:@"items"];
          
          NSString* countOfSub = [tempDict objectForKey:@"count"];
                    
          //NSLog(@"users.getFollowers JSON: %@", dictArray);
          
          NSMutableArray* objectsArray = [NSMutableArray array];
          
          for (NSDictionary* dict in dictArray) {
              ASFollower * subscriber = [[ASFollower alloc] initWithServerResponse:dict];
              [objectsArray addObject:subscriber];
          }
          
          if (success) {
              success(objectsArray, (int)[countOfSub integerValue]);
          }
          
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
          NSLog(@"Error: %@", error);
          
          if (failure) {
              failure(error, operation.response.statusCode);
          }
          
      }];
}




@end
