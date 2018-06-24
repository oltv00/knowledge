//
//  OLTVMessage.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 21/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVMessage.h"

@implementation OLTVMessage

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject {
  self = [super init];
  if (self) {
    
    _messageID = responseObject[@"id"];
    _body = responseObject[@"body"];
    _from_id = responseObject[@"from_id"];
    
  }
  return self;
}

@end
