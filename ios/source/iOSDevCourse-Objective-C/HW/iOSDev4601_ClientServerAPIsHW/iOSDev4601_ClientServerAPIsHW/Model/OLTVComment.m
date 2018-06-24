//
//  OLTVComment.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 29/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVComment.h"

@implementation OLTVComment

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject {
  self = [super init];
  
  if (self) {
    
    NSTimeInterval interval = [responseObject[@"date"] doubleValue];
    _date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    _text = responseObject[@"text"];
    _from_id = responseObject[@"from_id"];
    _commentID = responseObject[@"id"];
  }
  
  return self;
}

- (NSString *)stringFromDate:(NSDate *)date {
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"HH:mm dd.MM.yyyy"];
  return [df stringFromDate:date];
}

@end
