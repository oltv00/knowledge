//
//  APIManager.h
//  Test-centr-delovih-innovacii
//
//  Created by Oleg Tverdokhleb on 11/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

// ENUM для передачи в completion блок контроллера.
typedef NS_ENUM(NSInteger, APIManagerServerResponse) {
  APIManagerServerResponseFailure = 0,
  APIManagerServerResponseSuccess = 1,
  APIManagerServerResponseWrongPassword = 2
};

@class SMRUser;

@interface APIManager : NSObject

+ (APIManager *)shared;

- (void)authUserWithLogin:(NSString *)login
                 password:(NSString *)password
               completion:(void(^)(APIManagerServerResponse status))completion;

- (void)uploadVideoWithName:(NSString *)name
                      video:(NSURL *)videoURL
                 compeltion:(void(^)(APIManagerServerResponse status))completion;

@end
