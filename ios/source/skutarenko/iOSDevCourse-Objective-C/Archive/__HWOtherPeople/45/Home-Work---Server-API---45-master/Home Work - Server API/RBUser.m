//
//  RBUser.m
//  Home Work - Server API
//
//  Created by Roman Bogomolov on 13/10/14.
//  Copyright (c) 2014 Roman Bogomolov. All rights reserved.
//

#import "RBUser.h"

@implementation RBUser

- (id) initWithServerResponse:(NSDictionary*) responseObject

{
    self = [super init];
    if (self) {
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName =  [responseObject objectForKey:@"last_name"];
        self.groupName =  [responseObject objectForKey:@"name"];
        self.groupType =  [responseObject objectForKey:@"type"];
        self.cityID =    [responseObject objectForKey:@"city"];
        self.countryID = [responseObject objectForKey:@"country"];
        self.isOnline =  [[responseObject objectForKey:@"online"] boolValue];
        self.userID =    [responseObject objectForKey:@"user_id"];
        self.imageURL_50 = [NSURL URLWithString:[responseObject objectForKey:@"photo_50"]];
        self.imageURL_100 = [NSURL URLWithString:[responseObject objectForKey:@"photo_100"]];
 }
    
    return self;
}

@end
