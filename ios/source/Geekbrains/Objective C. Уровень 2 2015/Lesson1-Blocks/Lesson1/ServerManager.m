//
//  ServerManager.m
//  Lesson1
//
//  Created by Oleg Tverdokhleb on 10.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ServerManager.h"

@implementation ServerManager

- (void)getImagesWithTag:(NSString *)tag
                   count:(NSInteger)count
               onSuccess:(void (^)(NSArray *))success
               onFailure:(void (^)(NSError *))failure
{
    
    NSMutableArray *mArray = [NSMutableArray array];
    //GET:
    NSDictionary *dicts = [NSDictionary
                           dictionaryWithObjectsAndKeys:
                           tag, @"tag",
                           count, @"count", nil];
    [mArray addObject:dicts];
    
    if (success) {
        
        success(mArray);
        
    } else {
        
        NSError *error = [[NSError alloc] init];
        failure(error);
    }
}

@end
