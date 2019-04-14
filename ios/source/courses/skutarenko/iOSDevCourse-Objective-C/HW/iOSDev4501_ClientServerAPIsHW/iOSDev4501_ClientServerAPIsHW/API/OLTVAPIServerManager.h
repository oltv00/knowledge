//
//  OLTVAPIServerManager.h
//  iOSDev4501_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 04/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OLTVDetailedUser;

@interface OLTVAPIServerManager : NSObject

+ (OLTVAPIServerManager *)sharedManager;

- (void)getFriendsWithOffset:(NSInteger)offset
                       count:(NSInteger)count
                   onSuccess:(void(^)(NSArray *friends))success
                   onFailure:(void(^)(NSError *error))failure;

- (void)getUserWithID:(NSString *)userID
            onSuccess:(void(^)(OLTVDetailedUser *user))success
            onFailure:(void(^)(NSError *error))failure;

- (void)getSubscriptionsWithUserID:(NSString *)userID
                            offset:(NSInteger)offset
                             count:(NSInteger)count
                         onSuccess:(void(^)(NSArray *users, NSArray *groups))success
                         onFailure:(void(^)(NSError *error))failure;

- (void)getFollowersWithUserID:(NSString *)userID
                        offset:(NSInteger)offset
                         count:(NSInteger)count
                     onSuccess:(void(^)(NSArray *users))success
                     onFailure:(void(^)(NSError *error))failure;

- (void)getWallWithUserID:(NSString *)userID
                   offset:(NSInteger)offset
                    count:(NSInteger)count
                onSuccess:(void(^)(NSArray *wall))success
                onFailure:(void(^)(NSError *error))failure;

@end
