//
//  ServerManager.h
//  Lesson1
//
//  Created by Oleg Tverdokhleb on 10.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerManager : NSObject

- (void) getImagesWithTag:(NSString *) tag
                    count:(NSInteger) count
                 onSuccess:(void(^)(NSArray *array)) success
                onFailure:(void(^)(NSError *error)) failure;

@end
