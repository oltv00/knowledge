//
//  OLTVPhoto.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 07/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVPhoto.h"

@implementation OLTVPhoto

- (instancetype)initWithResponse:(NSDictionary *)response {
  self = [super init];
  if (self) {
    
    _albumID = response[@"album_id"];
    _photoID = response[@"id"];
    _ownerID = response[@"owner_id"];
    _userID = response[@"user_id"];
    _text = response[@"text"];
    
    NSString *photoStringURL = response[@"photo_604"];
    if (photoStringURL) {
      _photoURL = [NSURL URLWithString:photoStringURL];
    }
    
    NSTimeInterval dateInterval = [response[@"date"] doubleValue];
    _date = [NSDate dateWithTimeIntervalSince1970:dateInterval];
   
    _height = response[@"height"];
    _width = response[@"width"];
    
  }
  return self;
}

@end
