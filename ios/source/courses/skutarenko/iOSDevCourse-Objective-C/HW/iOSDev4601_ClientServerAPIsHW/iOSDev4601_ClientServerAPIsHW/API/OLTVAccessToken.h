//
//  OLTVAccessToken.h
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 19/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OLTVAccessToken : NSObject

@property (strong, nonatomic) NSString *access_token;
@property (strong, nonatomic) NSDate *expires_in;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *email;

- (instancetype)initWithComponents:(NSDictionary *)components;

@end
