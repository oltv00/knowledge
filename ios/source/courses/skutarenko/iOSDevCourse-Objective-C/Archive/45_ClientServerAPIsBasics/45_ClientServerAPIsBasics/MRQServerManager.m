//
//  MRQServerManager.m
//  45_ClientServerAPIsBasics
//
//  Created by Oleg Tverdokhleb on 17.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQServerManager.h"
#import "AFNetworking.h"
#import "MRQUser.h"


@implementation MRQServerManager

+ (MRQServerManager *) sharedManager {
    
    static MRQServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[MRQServerManager alloc] init];
    });
    
    return manager;
}

-(void)getFriendsWithOffset:(NSInteger)offset
                      count:(NSInteger)count
                  onSuccess:(void (^)(NSArray *))success
                  onFailure:(void (^)(NSError *))failure
{
    /*
    https://api.vk.com/method/friends.get?
    user_id 286385229
    order name
    count 5
    offset 0
    fields photo_50
    name_case nom
    */
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"286385229",   @"user_id",
                                @"name",        @"order",
                                @(count),       @"count",
                                @(offset),      @"offset",
                                @"photo_50",    @"fields",
                                @"nom",         @"name_case", nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://api.vk.com/method/friends.get"
      parameters:parameters
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             
             NSLog(@"JSON: %@", responseObject);
             
             NSArray *dictionariesArray = [responseObject objectForKey:@"response"];

             NSMutableArray *objectsArray = [NSMutableArray array];
             for (NSDictionary *dicts in dictionariesArray) {
                 MRQUser *user = [[MRQUser alloc] initWithServerResponse:dicts];
                 [objectsArray addObject:user];
             }
             
             if (success) {
                 success(objectsArray);
             }
             
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        if (failure) {
            failure(error);
        }
    }];
}

@end
