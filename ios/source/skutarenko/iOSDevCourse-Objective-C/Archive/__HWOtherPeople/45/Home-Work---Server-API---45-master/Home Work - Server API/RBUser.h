//
//  RBUser.h
//  Home Work - Server API
//
//  Created by Roman Bogomolov on 13/10/14.
//  Copyright (c) 2014 Roman Bogomolov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBUser : NSObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (assign, nonatomic) BOOL isOnline;
@property (strong, nonatomic) NSString* userID;
@property (assign, nonatomic) NSString* cityID;
@property (assign, nonatomic) NSString* countryID;
@property (strong, nonatomic) NSURL* imageURL_50;
@property (strong, nonatomic) NSURL* imageURL_100;
@property (strong, nonatomic) NSString* groupName;
@property (strong, nonatomic) NSString* groupType;



- (id) initWithServerResponse:(NSDictionary*) responseObject;

@end
