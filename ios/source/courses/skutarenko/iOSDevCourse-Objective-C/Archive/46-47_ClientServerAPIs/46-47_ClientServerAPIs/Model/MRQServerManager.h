//
//  MRQServerManager.h
//  46-47_ClientServerAPIs
//
//  Created by Oleg Tverdokhleb on 24.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRQUser;

@interface MRQServerManager : NSObject

+ (MRQServerManager *) sharedManager;

-(void)authorizeUser:(void(^)(MRQUser *user)) completion;

- (void)getUser:(NSString *) userID
      onSuccess:(void(^)(MRQUser *user)) success
      onFailure:(void(^)(NSError *error)) failure;

@end
