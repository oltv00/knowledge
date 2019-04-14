//
//  RBUserWall.m
//  Home Work - Server API
//
//  Created by Roman Bogomolov on 14/10/14.
//  Copyright (c) 2014 Roman Bogomolov. All rights reserved.
//

#import "RBUserWall.h"

@implementation RBUserWall

- (id) initWithServerResponse:(NSDictionary*) responseObject

{
    self = [super init];
    if (self) {
        self.text = [responseObject objectForKey:@"text"];
        self.imageURL_50 = [responseObject objectForKey:@"photo_50"];
        
        NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
        [dateFormater setDateFormat:@"dd MMM yyyy "];
        NSDate *dateTime = [NSDate dateWithTimeIntervalSince1970:[[responseObject objectForKey:@"date"] floatValue]];
        NSString *date = [dateFormater stringFromDate:dateTime];
        self.date = date;
        
        NSDictionary *dict = [[responseObject objectForKey:@"attachment"] objectForKey:@"photo"];
        
        self.postImageURL = [NSURL URLWithString:[dict objectForKey:@"src_big"]];
        
        self.heightImage = [[dict objectForKey:@"height"] integerValue] / 2;

        
            }
    
    return self;
}

@end
