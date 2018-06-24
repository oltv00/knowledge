//
//  OLTVGroup.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 05/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVGroup.h"

@implementation OLTVGroupMenu

- (instancetype)initWithTitle:(NSString *)title count:(NSString *)count {
  self = [super init];
  if (self) {
    _title = title;
    _count = count;
  }
  return self;
}

@end

@implementation OLTVGroup

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject {
  self = [super init];
  if (self) {
    
    _groupID = responseObject[@"id"];
    _name = responseObject[@"name"];
    _descrip = responseObject[@"description"];
    _site = responseObject[@"site"];
    _menu = [NSMutableArray array];
    
    OLTVGroupMenu *item = [OLTVGroupMenu new];
    item.title = @"members";
    item.count = [responseObject[@"members_count"] stringValue];
    [_menu addObject:item];
    
    NSDictionary *counters = responseObject[@"counters"];
    for (id key in counters) {
      if (![key isEqualToString:@"albums"]) {
        OLTVGroupMenu *item = [[OLTVGroupMenu alloc]
                               initWithTitle:key
                               count:[counters[key] stringValue]];
        [_menu addObject:item];
      }
    }
    
    NSString *stringURL = responseObject[@"photo_100"];
    if (stringURL) {
      _photoURL = [NSURL URLWithString:stringURL];
    }
  }
  return self;
}

@end


