//
//  OLTVAccessToken.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 19/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVAccessToken.h"

@implementation OLTVAccessToken

- (instancetype)initWithComponents:(NSDictionary *)components {
  self = [super init];
  if (self) {
    
    _access_token = components[@"access_token"];
    _expires_in = [NSDate dateWithTimeIntervalSinceNow:[components[@"expires_in"] doubleValue]];
    _userID = components[@"user_id"];
    
    if (components[@"email"]) {
      _email = components[@"email"];
    }
  }
  return self;
}

@end
