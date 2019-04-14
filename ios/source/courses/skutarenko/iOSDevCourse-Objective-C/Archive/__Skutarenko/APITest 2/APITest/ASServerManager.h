//
//  ASServerManager.h
//  APITest
//
//  Created by Oleksii Skutarenko on 20.02.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASUser;

@interface ASServerManager : NSObject

@property (strong, nonatomic, readonly) ASUser* currentUser;

+ (ASServerManager*) sharedManager;

- (void) authorizeUser:(void(^)(ASUser* user)) completion;

- (void) getUser:(NSString*) userID
       onSuccess:(void(^)(ASUser* user)) success
       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getFriendsWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray* friends)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;


@end
