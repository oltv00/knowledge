//
//  MRQServerManager.h
//  45_ClientServerAPIsBasicsHWRestoProg
//
//  Created by Oleg Tverdokhleb on 17.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRQServerManager : NSObject

+ (MRQServerManager*) sharedManager;

- (void)getFriendsWithOffset:(NSInteger) offset
                       count:(NSInteger) count
                   onSuccess:(void(^)(NSArray *friends)) success
                   onFailure:(void(^)(NSError *error)) failure;

- (void)getDetailedUserWithID:(NSInteger) userID
                    onSuccess:(void(^)(NSArray * userInfo)) success
                    onFailure:(void(^)(NSError* error)) failure;

- (void)getFollowersWithUserID:(NSInteger) userID
                        offset:(NSInteger) offset
                         count:(NSInteger) count
                     onSuccess:(void(^)(NSArray *followers, NSInteger countOfFollowers)) success
                     onFailure:(void(^)(NSError *error)) failure;

- (void)getSubscriptionsWithUserID:(NSInteger) userID
                            offset:(NSInteger) offset
                             count:(NSInteger) count
                         onSuccess:(void(^)(NSArray *subs, NSInteger countOfSubs)) success
                         onFailure:(void(^)(NSError *error)) failure;

- (void)getWallWithUserID:(NSInteger) userID
                   offset:(NSInteger) offset
                    count:(NSInteger) count
                onSuccess:(void(^)(NSArray *wall)) success
                onFailure:(void(^)(NSError *error)) failure;

@end
