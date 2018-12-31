//
//  SMRUser.m
//  Test-centr-delovih-innovacii
//
//  Created by Oleg Tverdokhleb on 11/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "SMRUser.h"

@implementation SMRUser

- (instancetype)initWithResponse:(NSDictionary *)response
{
  self = [super init];
  if (self) {
    _user_id = response[@"user_id"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.user_id forKey:@"user_id"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
  SMRUser *user = [[SMRUser alloc] init];
  user.user_id = [aDecoder decodeObjectForKey:@"user_id"];
  
  return user;
}

@end
