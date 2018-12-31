//
//  OLTVVideo.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 13/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVVideo.h"

@implementation OLTVVideo

- (instancetype)initWithResponseObject:(NSDictionary *)response {
  self = [super init];
  if (self) {
    
    _descrip = response[@"description"];
    _videoID = response[@"id"];
    _ownerID = response[@"owner_id"];
    _title = response[@"title"];
    _views = [response[@"views"] stringValue];
    _comments = [response[@"comments"] stringValue];
    
    NSDictionary *likes = response[@"likes"];
    _likes = [likes[@"count"] stringValue];
    
    NSTimeInterval interval = [response[@"duration"] doubleValue];
    NSDate *durDate = [NSDate dateWithTimeIntervalSinceNow:interval];
    if (interval < 3600) {
      _duration = [self stringWithMinutesFromDate:durDate];
    } else {
      _duration = [self stringWithHoursFromDate:durDate];
    }
    
    NSString *stringPhotoURL = response[@"photo_320"];
    if (stringPhotoURL) {
      _photoURL = [NSURL URLWithString:stringPhotoURL];
    }
    
    NSString *stringVideoURL = response[@"player"];
    if (stringVideoURL) {
      _videoURL = [NSURL URLWithString:stringVideoURL];
    }
    
  }
  return self;
}

- (NSString *)stringWithHoursFromDate:(NSDate *)date {
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"HH:mm:ss"];
  return [df stringFromDate:date];
}

- (NSString *)stringWithMinutesFromDate:(NSDate *)date {
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"mm:ss"];
  return [df stringFromDate:date];
}

@end
