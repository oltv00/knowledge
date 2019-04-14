//
//  OLTVServerManager.h
//  iOSDev4501_APITest
//
//  Created by Oleg Tverdokhleb on 02/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OLTVServerManager : NSObject

+ (OLTVServerManager *)sharedManager;

- (void)getFriendsWithOffset:(NSInteger)offset
                       count:(NSInteger)count
                   onSuccess:(void(^)(NSArray *friends))success
                   onFailure:(void(^)(NSError *error, NSInteger statusCode))failure;

@end
