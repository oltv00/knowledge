//
//  RBUserWall.h
//  Home Work - Server API
//
//  Created by Roman Bogomolov on 14/10/14.
//  Copyright (c) 2014 Roman Bogomolov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBUserWall : NSObject

@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) NSURL* imageURL_50;

@property (strong,nonatomic) NSString *date;
@property (strong,nonatomic) NSURL *postImageURL;
@property (assign, nonatomic) NSInteger heightImage;




- (id) initWithServerResponse:(NSDictionary*) responseObject;

@end
