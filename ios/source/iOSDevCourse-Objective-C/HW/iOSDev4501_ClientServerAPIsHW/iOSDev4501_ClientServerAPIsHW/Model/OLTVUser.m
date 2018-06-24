//
//  OLTVUser.m
//  iOSDev4501_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 04/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVUser.h"

@implementation OLTVUser

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject {
  self = [super init];
  if (self) {
    
    _firstName = responseObject[@"first_name"];
    _lastName = responseObject[@"last_name"];
    _userID = responseObject[@"id"];
    
    NSString *stringURL = responseObject[@"photo_50"];
    if (stringURL && [stringURL isKindOfClass:[NSString class]]) {
      _imageURL = [NSURL URLWithString:stringURL];
    }
  }
  
  return self;
}

@end
