//
//  RBServerManager.h
//  Home Work - Server API
//
//  Created by Roman Bogomolov on 13/10/14.
//  Copyright (c) 2014 Roman Bogomolov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RBUser;

@interface RBServerManager : NSObject

+ (RBServerManager*) sharedManager;

- (void) gerFriendsFromServerWithOffset:(NSInteger) offset
                              count:(NSInteger) count
                              onSuccess:(void(^)(NSArray* friends)) success
                              onFailure:(void(^)(NSError* error)) failure;

- (void) getCitiesById:(NSString*) cityID
             onSuccess:(void(^)(NSString* city)) success
             onFailure:(void(^)(NSError* error)) failure;

- (void) getCountriesById:(NSString*) cityID
                              onSuccess:(void(^)(NSString* country)) success
                              onFailure:(void(^)(NSError* error)) failure;

- (void) getUsers_ids:(NSString*) userID
                              onSuccess:(void(^)(RBUser* user)) success
                              onFailure:(void(^)(NSError* error)) failure;

- (void) getFollowers:(NSString*) userID
                              withOffset:(NSInteger) offset
                              count:(NSInteger) count
                              onSuccess:(void(^)(NSArray* followersArray)) success
                              onFailure:(void(^)(NSError* error)) failure;

- (void) getSubscribers:(NSString*) userID
           withOffset:(NSInteger) offset
                count:(NSInteger) count
            onSuccess:(void(^)(NSArray* subscribersArray)) success
            onFailure:(void(^)(NSError* error)) failure;

- (void) getUserWall:(NSString*) userID
                              withOffset:(NSInteger) offset
                              count:(NSInteger) count
                              onSuccess:(void(^)(NSArray* wallArray)) success
                              onFailure:(void(^)(NSError* error)) failure;

@end
