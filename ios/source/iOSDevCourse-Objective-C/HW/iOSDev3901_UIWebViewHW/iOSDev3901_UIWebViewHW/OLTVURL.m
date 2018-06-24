//
//  OLTV_URL.m
//  iOSDev3901_UIWebViewHW
//
//  Created by Oleg Tverdokhleb on 15/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVURL.h"

@implementation OLTVURL

- (OLTVURL *)initWithURLRequest:(NSURLRequest *)URLRequest {
  self = [super init];
  if (self) {
    _urlName = [URLRequest.URL.absoluteString lastPathComponent];
    _URLRequest = URLRequest;
  }
  return self;
}

@end
