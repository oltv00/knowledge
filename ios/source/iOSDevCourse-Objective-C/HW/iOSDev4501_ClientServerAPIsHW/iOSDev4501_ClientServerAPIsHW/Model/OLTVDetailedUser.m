//
//  OLTVDetailedUser.m
//  iOSDev4501_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 04/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVDetailedUser.h"

@implementation OLTVDetailedUser

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject {
  self = [super init];
  if (self) {
    
    _firstName = responseObject[@"first_name"];
    _lastName = responseObject[@"last_name"];
    
    NSString *stringURL = responseObject[@"photo_max_orig"];
    if (stringURL) {
      _imageURL = [NSURL URLWithString:stringURL];
    }
  }
  return self;
}

@end
