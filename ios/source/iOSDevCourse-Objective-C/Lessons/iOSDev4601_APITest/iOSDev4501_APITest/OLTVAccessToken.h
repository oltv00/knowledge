//
//  OLTVAccessToken.h
//  iOSDev4501_APITest
//
//  Created by Oleg Tverdokhleb on 14/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OLTVAccessToken : NSObject

@property (strong, nonatomic) NSString *access_token;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSDate *expires_in;

@end
