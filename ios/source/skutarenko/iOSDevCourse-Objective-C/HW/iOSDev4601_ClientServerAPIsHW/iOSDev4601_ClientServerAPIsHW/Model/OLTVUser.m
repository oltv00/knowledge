//
//  OLTVUser.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 19/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVUser.h"

@implementation OLTVUser

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject {
  self = [super init];
  if (self) {
    
    _first_name = responseObject[@"first_name"];
    _last_name = responseObject[@"last_name"];
    _userID = responseObject[@"id"];
    
    NSString *stringURL = responseObject[@"photo_50"];
    if (stringURL) {
      _photoURL = [NSURL URLWithString:stringURL];
    }
  }
  return self;
}

- (void)dealloc {
  //NSLog(@"%@ is deallocated", self);
}

@end
