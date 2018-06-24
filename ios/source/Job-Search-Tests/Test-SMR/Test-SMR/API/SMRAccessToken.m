//
//  SMRAccessToken.m
//  Test-centr-delovih-innovacii
//
//  Created by Oleg Tverdokhleb on 11/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "SMRAccessToken.h"

@implementation SMRAccessToken

- (instancetype)initWithResponse:(NSDictionary *)response {
  self = [super init];
  if (self) {
    
    _token = response[@"access_token"];
    _token_type = response[@"token_type"];
    _expires_in = [NSDate dateWithTimeIntervalSinceNow:[response[@"expires_in"] doubleValue]];
    
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.token forKey:@"token"];
  [aCoder encodeObject:self.token_type forKey:@"token_type"];
  [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
  SMRAccessToken *accessToken = [SMRAccessToken new];
  accessToken.token = [aDecoder decodeObjectForKey:@"token"];
  accessToken.token_type = [aDecoder decodeObjectForKey:@"token_type"];
  accessToken.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
  return accessToken;
}

@end
