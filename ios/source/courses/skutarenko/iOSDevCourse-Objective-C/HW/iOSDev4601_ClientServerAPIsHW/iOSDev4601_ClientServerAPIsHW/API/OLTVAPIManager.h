//
//  OLTVAPIManager.h
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 19/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//Model
@class OLTVUser;
@class OLTVGroup;
@class OLTVAccessToken;
@class OLTVPhotoAlbum;

@interface OLTVAPIManager : NSObject

+ (OLTVAPIManager *)sharedManager;

#pragma mark - ---=== AUTH ===---
- (void)authorizeUser:(void(^)(OLTVUser *user))success
              failure:(void(^)(NSError *error))failure;

#pragma mark - ---=== GET ===---

#pragma mark - User
- (void)getUserWithUserID:(NSString *)userID
                  success:(void(^)(OLTVUser *user))success
                  failure:(void(^)(NSError *error))failure;

#pragma mark - Group
- (void)getGroupWallWithOwnerID:(NSString *)ownerID
                         offset:(NSInteger)offset
                          count:(NSInteger)count
                        success:(void(^)(NSArray *wallPosts))success
                        failure:(void(^)(NSError *error))failure;

- (void)getGroupByID:(NSString *)groupID
          completion:(void(^)(OLTVGroup *group, NSError *error))completion;

#pragma mark - Message
- (void)getMessagesHistoryWithUserID:(NSString *)userID
                              offset:(NSInteger)offset
                               count:(NSInteger)count
                             success:(void(^)(NSArray *messages))success
                             failure:(void(^)(NSError *error))failure;

#pragma mark - Wall
- (void)getWallPostCommentsWithOwnerID:(NSString *)ownerID
                                postID:(NSString *)postID
                                offset:(NSInteger)offset
                                 count:(NSInteger)count
                               success:(void(^)(NSArray *comments))success
                               failure:(void(^)(NSError *error))failure;
#pragma mark - Photo
- (void)getPhotoAlbumsWithOwnerID:(NSString *)ownerID
                           offset:(NSInteger)offset
                            count:(NSInteger)count
                       completion:(void(^)(NSArray *photoAlbums, NSError *error))completion;

- (void)getPhotosWithOwnerID:(NSString *)ownerID
                     albumID:(NSString *)albumID
                      offset:(NSInteger)offset
                       count:(NSInteger)count
                  completion:(void(^)(NSArray *photos, NSError *error))completion;

- (void)getPhotoAlbumWithAllPhotosWithOwnerID:(NSString *)ownerID
                                       offset:(NSInteger)offset
                                        count:(NSInteger)count
                                   completion:(void(^)(NSArray *photos, NSString *size, NSError *error))completion;

#pragma mark - Video
- (void)getVideoAlbumsWithOwnerID:(NSString *)ownerID
                           offset:(NSInteger)offset
                            count:(NSInteger)count
                       completion:(void(^)(NSArray *albums, NSError *error))completion;

- (void)getVideosWithOwnerID:(NSString *)ownerID
                     albumID:(NSString *)albumID
                      offset:(NSInteger)offset
                       count:(NSInteger)count
                  completion:(void(^)(NSArray *videos, NSError *error))completion;

- (void)getVideoCommentsWithOwnerID:(NSString *)ownerID
                            videoID:(NSString *)videoID
                             offset:(NSInteger)offset
                              count:(NSInteger)count
                            success:(void(^)(NSArray *comments))success
                            failure:(void(^)(NSError *error))failure;

#pragma mark - ---=== POST ===---

#pragma mark - Message
- (void)postMessageToWallWithOwnerID:(NSString *)ownerID
                             message:(NSString *)message;

- (void)postMessageToUserWithID:(NSString *)userID
                        message:(NSString *)message
                     completion:(void(^)(id response, NSError *error))completion;

- (void)postMessageToWallPostWithOwnerID:(NSString *)ownerID
                                  postID:(NSString *)postID
                                 message:(NSString *)message
                              completion:(void(^)(id response, NSError *error))completion;
#pragma mark - Like
- (void)postLikeToType:(NSString *)type
               ownerID:(NSString *)ownerID
                itemID:(NSString *)itemID
            completion:(void(^)(NSDictionary *response, NSError *error))completion;

#pragma mark - Photo
- (void)uploadPhoto:(UIImage *)photo
              album:(NSString *)albumID
              group:(NSString *)groupID
           progress:(void(^)(CGFloat progress))progress
         completion:(void(^)(NSError *error))completion;

@end






























