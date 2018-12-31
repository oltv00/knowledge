//
//  OLTVAPIManager.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 19/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVAPIManager.h"

//Controller
#import "../Controller/OLTVLoginViewController.h"

//API
#import "../API/OLTVAccessToken.h"

//Libs
#import "../Libs/AFNetworking/AFNetworking.h"

//Model
#import "../Model/OLTVUser.h"
#import "../Model/OLTVPost.h"
#import "../Model/OLTVMessage.h"
#import "../Model/OLTVComment.h"
#import "../Model/OLTVGroup.h"
#import "../Model/OLTVPhotoAlbum.h"
#import "../Model/OLTVPhoto.h"
#import "../Model/OLTVVideoAlbum.h"
#import "../Model/OLTVVideo.h"

@interface OLTVAPIManager ()
@property (strong, nonatomic) OLTVAccessToken *token;
@end

@implementation OLTVAPIManager

+ (OLTVAPIManager *)sharedManager {
  static OLTVAPIManager *manager = nil;
  static dispatch_once_t token;
  dispatch_once(&token, ^{
    manager = [[OLTVAPIManager alloc] init];
  });
  return manager;
}

#pragma mark - ---=== AUTH ===---

- (void)authorizeUser:(void(^)(OLTVUser *user))success
              failure:(void(^)(NSError *error))failure
{
  if (!self.token) {
    OLTVLoginViewController *vc = [[OLTVLoginViewController alloc] initWithCompletionBlock:^(OLTVAccessToken *token) {
      
      self.token = token;
      
      [self getUserWithUserID:token.userID
                      success:^(OLTVUser *user) {
                        if (user) {
                          if (success) success(user);
                        } else {
                          NSError *error = [NSError errorWithDomain:@"User is nil" code:001 userInfo:nil];
                          failure(error);
                        }
                      }
                      failure:^(NSError *error) {
                        if (failure) failure(error);
                      }];
    }];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    UIViewController* mainVC = [[[[UIApplication sharedApplication] windows] firstObject] rootViewController];
    [mainVC presentViewController:nc animated:YES completion:nil];
  }
}

#pragma mark - ---=== GET METHODS ===---

#pragma mark - User
- (void)getUserWithUserID:(NSString *)userID
                  success:(void(^)(OLTVUser *user))success
                  failure:(void(^)(NSError *error))failure
{
  NSDictionary *parameters = @{
                               @"user_ids"  : userID,
                               @"fields"    : @"photo_50",
                               @"name_case" : @"nom",
                               @"v"         : @"5.52"
                               };
  
  [[AFHTTPSessionManager manager]
   GET:@"https://api.vk.com/method/users.get"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     NSArray *responseArray = responseObject[@"response"];
     NSDictionary *params = [responseArray firstObject];
     OLTVUser *user = [[OLTVUser alloc] initWithResponseObject:params];
     if (success) success(user);
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (failure) failure(error);
   }];
}

#pragma mark - Group
- (void)getGroupWallWithOwnerID:(NSString *)ownerID
                         offset:(NSInteger)offset
                          count:(NSInteger)count
                        success:(void(^)(NSArray *wallPosts))success
                        failure:(void(^)(NSError *error))failure
{
  if (![ownerID hasPrefix:@"-"]) {
    ownerID = [@"-" stringByAppendingString:ownerID];
  }
  
  NSDictionary *parametes = @{
                              @"owner_id" : ownerID,
                              @"offset"   : @(offset),
                              @"count"    : @(count),
                              @"filter"   : @"all",
                              @"extended" : @"0",
                              @"fields"   : @"",
                              @"v"        : @"5.52"
                              };
  
  [[AFHTTPSessionManager manager]
   GET:@"https://api.vk.com/method/wall.get"
   parameters:parametes
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //NSLog(@"%@", responseObject);
     NSDictionary *response = responseObject[@"response"];
     NSArray *items = response[@"items"];
     NSMutableArray *posts = [NSMutableArray array];
     for (NSDictionary *item in items) {
       //NSLog(@"%@", item);
       OLTVPost *post = [[OLTVPost alloc] initWithResponseObject:item];
       
       if (post) {
         
         // users
         [self getUserWithUserID:post.from_id success:^(OLTVUser *user) {
           //NSLog(@"%@", user);
           if (user) {
             post.user = user;
           }
         } failure:^(NSError *error) {
           NSLog(@"getUserWithUserID error = %@", [error localizedDescription]);
         }];
       }
       [posts addObject:post];
     }
     
     if (success) success(posts);
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (failure) failure(error);
   }];
}

- (void)getGroupByID:(NSString *)groupID
          completion:(void(^)(OLTVGroup *group, NSError *error))completion
{
  NSDictionary *parameters = @{
                               @"group_ids"    : groupID,
                               @"fields"       : @"description,members_count,site,counters",
                               @"v"            : @"5.52"
                               //@"access_token" : self.token.access_token
                               };
  
  [[AFHTTPSessionManager manager]
   GET:@"https://api.vk.com/method/groups.getById"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //NSLog(@"responseObject = %@", responseObject);
     NSDictionary *response = [responseObject[@"response"] firstObject];
     
     OLTVGroup *group = [[OLTVGroup alloc] initWithResponseObject:response];
     
     if (completion) {
       completion(group, nil);
     }
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (completion) {
       completion(nil, error);
     }
   }];
}

#pragma mark - Message
- (void)getMessagesHistoryWithUserID:(NSString *)userID
                              offset:(NSInteger)offset
                               count:(NSInteger)count
                             success:(void(^)(NSArray *messages))success
                             failure:(void(^)(NSError *error))failure
{
  NSDictionary *parameters = @{
                               @"user_id"      : userID,
                               @"offset"       : @(offset),
                               @"count"        : @(count),
                               @"v"            : @"5.52",
                               @"access_token" : self.token.access_token
                               };
  
  [[AFHTTPSessionManager manager]
   GET:@"https://api.vk.com/method/messages.getHistory"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //NSLog(@"%@", responseObject);
     NSDictionary *response = responseObject[@"response"];
     NSArray *items = response[@"items"];
     
     NSMutableArray *messages = [NSMutableArray array];
     for (NSDictionary *item in items) {
       //NSLog(@"%@", item);
       OLTVMessage *message = [[OLTVMessage alloc] initWithResponseObject:item];
       
       if ([[message.from_id stringValue] isEqualToString:self.token.userID]) {
         message.type = OLTVMessageTypeMine;
       } else {
         message.type = OLTVMessageTypeYour;
       }
       
       [messages addObject:message];
     }
     if (success) success(messages);
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (failure) failure(error);
   }];
}

#pragma mark - Wall
- (void)getWallPostCommentsWithOwnerID:(NSString *)ownerID
                                postID:(NSString *)postID
                                offset:(NSInteger)offset
                                 count:(NSInteger)count
                               success:(void(^)(NSArray *comments))success
                               failure:(void(^)(NSError *error))failure
{
  NSDictionary *parameters = @{
                               @"owner_id"     : ownerID,
                               @"post_id"      : postID,
                               @"need_likes"   : @1,
                               @"offset"       : @(offset),
                               @"count"        : @(count),
                               @"v"            : @"5.52",
                               @"access_token" : self.token.access_token
                               };
  
  [[AFHTTPSessionManager manager]
   GET:@"https://api.vk.com/method/wall.getComments"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //NSLog(@"%@", responseObject);
     NSDictionary *response = responseObject[@"response"];
     NSArray *items = response[@"items"];
     
     NSMutableArray *comments = [NSMutableArray array];
     for (NSDictionary *item in items) {
       OLTVComment *comment = [[OLTVComment alloc] initWithResponseObject:item];
       
       if (comment) {
         
         [self getUserWithUserID:comment.from_id
                         success:^(OLTVUser *user) {
                           if (user) {
                             comment.user = user;
                           }
                         }
                         failure:^(NSError *error) {
                           NSLog(@"getWallPostCommentsWithOwnerID getUserWithUserID error = %@", [error localizedDescription]);
                         }];
       }
       
       [comments addObject:comment];
     }
     
     if (success) success(comments);
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (failure) {
       failure(error);
     }
   }];
}

#pragma mark - Photo
- (void)getPhotoAlbumsWithOwnerID:(NSString *)ownerID
                           offset:(NSInteger)offset
                            count:(NSInteger)count
                       completion:(void(^)(NSArray *photoAlbums, NSError *error))completion
{
  NSString *ownerIDString = [(NSNumber *)ownerID stringValue];
  if (![ownerIDString hasPrefix:@"-"]) {
    ownerID = [@"-" stringByAppendingString:ownerIDString];
  }
  
  NSDictionary *parameters = @{
                               @"owner_id"     : ownerID,
                               @"offset"       : @(offset),
                               @"count"        : @(count),
                               @"photo_sizes"  : @(1),
                               @"v"            : @"5.52",
                               @"access_token" : self.token.access_token
                               };
  
  [[AFHTTPSessionManager manager]
   GET:@"https://api.vk.com/method/photos.getAlbums"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //NSLog(@"responseObject = %@", responseObject);
     NSDictionary *response = responseObject[@"response"];
     NSArray *items = response[@"items"];
     
     NSMutableArray *photoAlbums = [NSMutableArray array];
     
     for (NSDictionary *item in items) {
       //NSLog(@"%@", item);
       OLTVPhotoAlbum *photoAlbum = [[OLTVPhotoAlbum alloc] initWithResponse:item];
       [photoAlbums addObject:photoAlbum];
     }
     
     for (OLTVPhotoAlbum *photoAlbum in photoAlbums) {
       
       static NSInteger const requestCount = 5;
       [self getPhotosWithOwnerID:ownerID
                          albumID:photoAlbum.albumID
                           offset:photoAlbum.photos.count
                            count:requestCount
                       completion:^(NSArray *photos, NSError *error) {
                         if (error) {
                           NSLog(@"getPhotosWithOwnerID error = %@", [error localizedDescription]);
                         } else {
                           
                           photoAlbum.state = OLTVPhotoAlbumStateDownloaded;
                           [photoAlbum.photos addObjectsFromArray:photos];
                           
                           if ([photoAlbum isEqual:[photoAlbums lastObject]]) {
                             if (completion) {
                               completion(photoAlbums, nil);
                             }
                           }
                         }
                       }];
     }
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (completion) {
       completion(nil, error);
     }
   }];
}

- (void)getPhotosWithOwnerID:(NSString *)ownerID
                     albumID:(NSString *)albumID
                      offset:(NSInteger)offset
                       count:(NSInteger)count
                  completion:(void(^)(NSArray *photos, NSError *error))completion
{
  NSDictionary *parameters = @{
                               @"owner_id"     : ownerID,
                               @"album_id"     : albumID,
                               @"rev"          : @(1),
                               @"offset"       : @(offset),
                               @"count"        : @(count),
                               @"v"            : @"5.52",
                               @"access_token" : self.token.access_token
                               };
  
  [[AFHTTPSessionManager manager]
   GET:@"https://api.vk.com/method/photos.get"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //NSLog(@"responseObject = %@", responseObject);
     NSDictionary *response = responseObject[@"response"];
     NSArray *items = response[@"items"];
     
     NSMutableArray *photos = [NSMutableArray array];
     for (NSDictionary *item in items) {
       //NSLog(@"item = %@", item);
       OLTVPhoto *photo = [[OLTVPhoto alloc] initWithResponse:item];
       [photos addObject:photo];
     }
     
     if (completion) {
       completion(photos, nil);
     }
     
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (completion) {
       completion(nil, error);
     }
   }];
}

- (void)getPhotoAlbumWithAllPhotosWithOwnerID:(NSString *)ownerID
                                       offset:(NSInteger)offset
                                        count:(NSInteger)count
                                   completion:(void(^)(NSArray *photos, NSString *size, NSError *error))completion
{
  NSString *ownerIDString = [(NSNumber *)ownerID stringValue];
  if (![ownerIDString hasPrefix:@"-"]) {
    ownerID = [@"-" stringByAppendingString:ownerIDString];
  }
  
  NSDictionary *parameters = @{
                               @"owner_id"     : ownerID,
                               @"offset"       : @(offset),
                               @"count"        : @(count),
                               @"v"            : @"5.52",
                               @"access_token" : self.token.access_token
                               };
  
  [[AFHTTPSessionManager manager]
   GET:@"https://api.vk.com/method/photos.getAll"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //NSLog(@"%@", responseObject);
     NSDictionary *response = responseObject[@"response"];
     NSArray *items = response[@"items"];
     
     NSMutableArray *photos = [NSMutableArray array];
     for (NSDictionary *item in items) {
       OLTVPhoto *photo = [[OLTVPhoto alloc] initWithResponse:item];
       [photos addObject:photo];
     }
     
     NSString *size = [response[@"count"] stringValue];
     
     if (completion) {
       completion(photos, size, nil);
     }
     
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (completion) {
       completion(nil, 0, error);
     }
   }];
}

#pragma mark - Video
- (void)getVideoAlbumsWithOwnerID:(NSString *)ownerID
                           offset:(NSInteger)offset
                            count:(NSInteger)count
                       completion:(void(^)(NSArray *albums, NSError *error))completion
{
  NSString *ownerIDString = [(NSNumber *)ownerID stringValue];
  if (![ownerIDString hasPrefix:@"-"]) {
    ownerID = [@"-" stringByAppendingString:ownerIDString];
  }
  
  NSDictionary *parameters = @{
                               @"owner_id"     : ownerID,
                               @"offset"       : @(offset),
                               @"count"        : @(count),
                               @"extended"     : @"1",
                               @"v"            : @"5.52",
                               @"access_token" : self.token.access_token
                               };
  
  [[AFHTTPSessionManager manager]
   GET:@"https://api.vk.com/method/video.getAlbums"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //NSLog(@"responseObject = %@", responseObject);
     NSDictionary *response = responseObject[@"response"];
     NSArray *items = response[@"items"];
     
     NSMutableArray *albums = [NSMutableArray array];
     for (NSDictionary *item in items) {
       OLTVVideoAlbum *album = [[OLTVVideoAlbum alloc] initWithResponseObject:item];
       [albums addObject:album];
     }
     
     if (completion) {
       completion(albums, nil);
     }
     
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     NSLog(@"video.getAlbums error = %@", [error localizedDescription]);
   }];
}

- (void)getVideosWithOwnerID:(NSString *)ownerID
                     albumID:(NSString *)albumID
                      offset:(NSInteger)offset
                       count:(NSInteger)count
                  completion:(void(^)(NSArray *videos, NSError *error))completion
{
  NSString *ownerIDString = [(NSNumber *)ownerID stringValue];
  if (![ownerIDString hasPrefix:@"-"]) {
    ownerID = [@"-" stringByAppendingString:ownerIDString];
  }
  
  NSDictionary *parameters = @{
                               @"owner_id"     : ownerID,
                               @"album_id"     : albumID,
                               @"count"        : @(count),
                               @"offset"       : @(offset),
                               @"extended"     : @"1",
                               @"v"            : @"5.52",
                               @"access_token" : self.token.access_token
                               };
  
  [[AFHTTPSessionManager manager]
   GET:@"https://api.vk.com/method/video.get"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //NSLog(@"responseObject = %@", responseObject);
     NSDictionary *response = responseObject[@"response"];
     NSArray *items = response[@"items"];
     NSMutableArray *videos = [NSMutableArray array];
     for (NSDictionary *item in items) {
       OLTVVideo *video = [[OLTVVideo alloc] initWithResponseObject:item];
       [videos addObject:video];
     }
     
     if (completion) {
       completion(videos, nil);
     }
     
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (completion) {
       completion(nil, error);
     }
   }];
}

- (void)getVideoCommentsWithOwnerID:(NSString *)ownerID
                            videoID:(NSString *)videoID
                             offset:(NSInteger)offset
                              count:(NSInteger)count
                            success:(void(^)(NSArray *comments))success
                            failure:(void(^)(NSError *error))failure
{
  NSDictionary *parameters = @{
                               @"owner_id"      : ownerID,
                               @"video_id"      : videoID,
                               @"need_likes"    : @1,
                               @"offset"        : @(offset),
                               @"count"         : @(count),
                               @"v"             : @"5.52",
                               @"access_token"  : self.token.access_token
                               };
  
  [[AFHTTPSessionManager manager]
   GET:@"https://api.vk.com/method/video.getComments"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //NSLog(@"responseObject = %@", responseObject);
     NSDictionary *response = responseObject[@"response"];
     NSArray *items = response[@"items"];
     
     NSMutableArray *comments = [NSMutableArray array];
     for (NSDictionary *item in items) {
       OLTVComment *comment = [[OLTVComment alloc] initWithResponseObject:item];
       
       if (comment) {
         
         [self getUserWithUserID:comment.from_id
                         success:^(OLTVUser *user) {
                           if (user) {
                             comment.user = user;
                           }
                         }
                         failure:^(NSError *error) {
                           NSLog(@"getWallPostCommentsWithOwnerID getUserWithUserID error = %@", [error localizedDescription]);
                         }];
       }
       
       [comments addObject:comment];
     }
     
     if (success) success(comments);
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (failure) failure(error);
   }];
}

#pragma mark - ---=== POST METHODS ===---

#pragma mark - Message
- (void)postMessageToWallWithOwnerID:(NSString *)ownerID
                             message:(NSString *)message
{
  NSDictionary *parameters = @{
                               @"owner_id"     : ownerID,
                               @"message"      : message,
                               @"access_token" : self.token.access_token,
                               @"v"            : @"5.52"
                               };
  
  [[AFHTTPSessionManager manager]
   POST:@"https://api.vk.com/method/wall.post"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     NSLog(@"%@", responseObject);
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     NSLog(@"%@", [error localizedDescription]);
   }];
}

- (void)postMessageToUserWithID:(NSString *)userID
                        message:(NSString *)message
                     completion:(void(^)(id response, NSError *error))completion
{
  NSDictionary *parameters = @{
                               @"user_id"      : @"286385229",
                               @"message"      : message,
                               @"access_token" : self.token.access_token,
                               @"v"            : @"5.52"
                               };
  
  [[AFHTTPSessionManager manager]
   POST:@"https://api.vk.com/method/messages.send"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     NSLog(@"%@", responseObject);
     if (completion) {
       completion(responseObject, nil);
     }
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     NSLog(@"%@", [error localizedDescription]);
     if (completion) {
       completion(nil, error);
     }
   }];
}

- (void)postMessageToWallPostWithOwnerID:(NSString *)ownerID
                                  postID:(NSString *)postID
                                 message:(NSString *)message
                              completion:(void(^)(id response, NSError *error))completion
{
  NSDictionary *parameters = @{
                               @"owner_id"     : ownerID,
                               @"post_id"      : postID,
                               @"message"      : message,
                               @"access_token" : self.token.access_token,
                               @"v"            : @"5.52"
                               };
  
  [[AFHTTPSessionManager manager]
   POST:@"https://api.vk.com/method/wall.createComment"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     if (completion) {
       completion(responseObject, nil);
     }
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (completion) {
       completion(nil, error);
     }
   }];
}

#pragma mark - Like

- (void)postLikeToType:(NSString *)type
               ownerID:(NSString *)ownerID
                itemID:(NSString *)itemID
            completion:(void(^)(NSDictionary *response, NSError *error))completion
{
  NSDictionary *isLikedParams = @{
                                  @"user_id"      : self.token.userID,
                                  @"type"         : type,
                                  @"owner_id"     : ownerID,
                                  @"item_id"      : itemID,
                                  @"access_token" : self.token.access_token,
                                  @"v"            : @"5.52"
                                  };
  
  NSDictionary *addLikeParams = @{
                                  @"type"         : type,
                                  @"owner_id"     : ownerID,
                                  @"item_id"      : itemID,
                                  @"access_token" : self.token.access_token,
                                  @"v"            : @"5.52"
                                  };
  
  NSDictionary *deleteLikeParams = @{
                                     @"type"         : type,
                                     @"owner_id"     : ownerID,
                                     @"item_id"      : itemID,
                                     @"access_token" : self.token.access_token,
                                     @"v"            : @"5.52"
                                     };
  
  [[AFHTTPSessionManager manager]
   POST:@"https://api.vk.com/method/likes.isLiked"
   parameters:isLikedParams
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //NSLog(@"likes.isLiked = %@", responseObject);
     NSDictionary *response = responseObject[@"response"];
     
     if (![response[@"liked"] integerValue]) {
       
       [[AFHTTPSessionManager manager]
        POST:@"https://api.vk.com/method/likes.add"
        parameters:addLikeParams
        progress:nil
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          //NSLog(@"likes.add = %@", responseObject);
          NSDictionary *response = responseObject[@"response"];
          
          if (completion) {
            completion(response, nil);
          }
        }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"likes.add error = %@", [error localizedDescription]);
        }];
       
     } else {
       
       [[AFHTTPSessionManager manager]
        POST:@"https://api.vk.com/method/likes.delete"
        parameters:deleteLikeParams
        progress:nil
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          //NSLog(@"likes.delete = %@", responseObject);
          NSDictionary *response = responseObject[@"response"];
          
          if (completion) {
            completion(response, nil);
          }
        }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"likes.delete error = %@", [error localizedDescription]);
        }];
       
     }
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     if (completion) {
       completion(nil, error);
     }
   }];
}

#pragma mark - Photo

- (void)uploadPhoto:(UIImage *)photo
              album:(NSString *)albumID
              group:(NSString *)groupID
           progress:(void(^)(CGFloat progress))progress
         completion:(void(^)(NSError *error))completion
{
  if ([groupID isKindOfClass:[NSNumber class]]) {
    NSNumber *groupIDNumber = (NSNumber *)groupID;
    if ([[groupIDNumber stringValue] hasPrefix:@"-"]) {
      groupID = [[groupIDNumber stringValue] substringFromIndex:1];
    }
  }
  
  NSDictionary *parameters = @{
                               @"album_id"     : albumID,
                               @"group_id"     : groupID,
                               @"access_token" : self.token.access_token,
                               @"v"            : @"5.52"
                               };
  [[AFHTTPSessionManager manager]
   POST:@"https://api.vk.com/method/photos.getUploadServer"
   parameters:parameters
   progress:nil
   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     //NSLog(@"%@", responseObject);
     
     NSDictionary *response = responseObject[@"response"];
     NSString *upload_url = response[@"upload_url"];
     NSData *upload_data = UIImageJPEGRepresentation(photo, 1.0f);
     
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
     [manager
      POST:upload_url
      parameters:nil
      constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:upload_data
                                    name:@"file1"
                                fileName:@"file1.jpg"
                                mimeType:@"image/jpeg"];
      }
      progress:^(NSProgress * _Nonnull uploadProgress) {
        CGFloat total = uploadProgress.totalUnitCount;
        CGFloat compl = uploadProgress.completedUnitCount;
        CGFloat percents = (compl / total);
        if (progress) {
          progress(percents);
        }
      }
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"%@", responseObject);
        
        NSNumber *aid = responseObject[@"aid"];
        NSNumber *gid = responseObject[@"gid"];
        NSNumber *hash = responseObject[@"hash"];
        NSNumber *server = responseObject[@"server"];
        NSString *photos_list = responseObject[@"photos_list"];
        
        NSDictionary *parameters = @{
                                     @"album_id"     : aid,
                                     @"group_id"     : gid,
                                     @"hash"         : hash,
                                     @"photos_list"  : photos_list,
                                     @"server"       : server,
                                     @"access_token" : self.token.access_token,
                                     @"v"            : @"5.52"
                                     
                                     };
        [[AFHTTPSessionManager manager]
         POST:@"https://api.vk.com/method/photos.save"
         parameters:parameters
         progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           //NSLog(@"responseObject = %@", responseObject);
           if (completion) {
             completion(nil);
           }
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           NSLog(@"%@ uploadPhotoToAlbum error = %@", [self class], [error localizedDescription]);
         }];
      }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@ uploadPhotoToAlbum error = %@", [self class], [error localizedDescription]);
      }];
   }
   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     NSLog(@"%@ uploadPhotoToAlbum error = %@", [self class], [error localizedDescription]);
   }];
}

















@end
