//
//  MRQServerManager.h
//  45_ClientServerAPIsBasics
//
//  Created by Oleg Tverdokhleb on 17.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRQServerManager : NSObject

+ (MRQServerManager *) sharedManager;

- (void) getFriendsWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray *friends)) success
                    onFailure:(void(^)(NSError *error)) failure;

@end
