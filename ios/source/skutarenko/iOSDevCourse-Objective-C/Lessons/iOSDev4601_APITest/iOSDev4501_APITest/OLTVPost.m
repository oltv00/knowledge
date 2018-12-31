//
//  OLTVPost.m
//  iOSDev4501_APITest
//
//  Created by Oleg Tverdokhleb on 16/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVPost.h"

@implementation OLTVPost

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject {
  self = [super initWithResponseObject:responseObject];
  if (self) {
    _text = responseObject[@"text"];
  }
  return self;
}


@end
