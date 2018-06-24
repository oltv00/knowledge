//
//  OLTVGroup.m
//  iOSDev4501_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 05/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVGroup.h"

@implementation OLTVGroup

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject {
  self = [super init];
  if (self) {
    _gid = responseObject[@"gid"];
    _name = responseObject[@"name"];
    
    NSString *stringURL = responseObject[@"photo_50"];
    if (stringURL) {
      _imageURL = [NSURL URLWithString:stringURL];
    }
  }
  return self;
}

@end
