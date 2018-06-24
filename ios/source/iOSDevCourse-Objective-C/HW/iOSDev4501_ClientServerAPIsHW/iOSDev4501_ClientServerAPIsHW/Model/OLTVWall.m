//
//  OLTVWall.m
//  iOSDev4501_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 07/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVWall.h"

@implementation OLTVWall

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject {
  self = [super init];
  if (self) {
    
    //date
    NSTimeInterval timeInterval = [responseObject[@"date"] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"dd.MM.yyyy HH:mm"];
    _dateString = [df stringFromDate:date];
    
    //from_id
    _from_id = responseObject[@"from_id"];
    
    //text body
    _text = responseObject[@"text"];
    _type = OLTVWallTypeText;
    
    //attachments
    NSArray *attachments = responseObject[@"attachments"];
    if (attachments) {
      
      //photo
      if ([[[attachments firstObject] objectForKey:@"type"] isEqualToString:@"photo"]) {
        
        _type = OLTVWallTypePhoto;
        
        NSDictionary *photo = [[attachments firstObject] objectForKey:@"photo"];
        NSString *stringURL = photo[@"photo_604"];
        if (stringURL) {
          _photoURL = [NSURL URLWithString:stringURL];
        }
                
        //link
      } else if ([[[attachments firstObject] objectForKey:@"type"] isEqualToString:@"link"]) {
        
        _type = OLTVWallTypeLink;
        
        NSDictionary *link = [[attachments firstObject] objectForKey:@"link"];
        
        _linkTitle = link[@"title"];
        _linkCaption = link[@"caption"];
        
        NSString *linkURLString = link[@"url"];
        if (linkURLString) {
          _linkURL = [NSURL URLWithString:linkURLString];
        }
      }
    }
  }
  
  return self;
}

@end
