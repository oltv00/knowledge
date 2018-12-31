//
//  OLTVVideoAlbum.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 11/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVVideoAlbum.h"

@implementation OLTVVideoAlbum

- (instancetype)initWithResponseObject:(NSDictionary *)response {
  self = [super init];
  if (self) {
    
    _albumID = response[@"id"];
    _ownerID = response[@"owner_id"];
    _title = response[@"title"];
    _count = [response[@"count"] stringValue];
    
    NSString *stringURL = response[@"photo_160"];
    if (stringURL) {
      _photoURL = [NSURL URLWithString:stringURL];
    }
    
  }
  return self;
}

@end
