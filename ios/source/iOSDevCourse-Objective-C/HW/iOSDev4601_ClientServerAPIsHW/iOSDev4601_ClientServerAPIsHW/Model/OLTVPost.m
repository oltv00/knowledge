//
//  OLTVWall.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 19/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVPost.h"

@implementation OLTVPost

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject {
  self = [super init];
  if (self) {
    
    _text = responseObject[@"text"];
    _likesCount = responseObject[@"likes"][@"count"];
    _commentsCount = responseObject[@"comments"][@"count"];
    
    NSTimeInterval interval = [responseObject[@"date"] doubleValue];
    _date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    _from_id = responseObject[@"from_id"];
    
    _owner_id = responseObject[@"owner_id"];
    _post_id = responseObject[@"id"];
    
  }
  return self;
}

- (NSString *)stringFromDate:(NSDate *)date {
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"HH:mm dd.MM.yyyy"];
  return [df stringFromDate:date];
}

@end
