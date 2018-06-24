//
//  APIManager.m
//  Lesson6
//
//  Created by Oleg Tverdokhleb on 24.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "APIManager.h"
#import <AFNetworking/AFNetworking.h>

@implementation APIManager

+ (APIManager *) sharedManager {

    static APIManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[APIManager alloc] init];
    });
    
    return manager;
}

+ (APIManager *)managerWithDelegate:(id<APIManagerDelegate>)aDelegate {
    
    return [[APIManager alloc] initWithDelegate:aDelegate];
}

- (instancetype)initWithDelegate:(id<APIManagerDelegate>)aDelegate {
    
    self = [super init];
    if (self) {
        _delegate = aDelegate;
    }
    return self;
}

#pragma mark API Requests

- (void)getRandomAdvice {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:@"http://fucking-great-advice.ru/api/random"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"%@", responseObject);
             if ([responseObject isKindOfClass:[NSDictionary class]]) {
                 NSString *encodeString = [responseObject objectForKey:@"text"];
                 NSString *string = [NSString stringWithUTF8String:[encodeString cStringUsingEncoding:NSUTF8StringEncoding]];
                 NSLog(@"%@", string);
                 if ([string rangeOfString:@"&nbsp;"].location != NSNotFound) {
                     NSLog(@"&nbsp;");
                 }
                 
                 [self.delegate getAdvice:responseObject];
//                 [responseObject setValue:string forKey:@"text"];
//                 NSLog(@"%@", responseObject);
             }
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"%@", [error localizedDescription]);
         }];
}

@end
