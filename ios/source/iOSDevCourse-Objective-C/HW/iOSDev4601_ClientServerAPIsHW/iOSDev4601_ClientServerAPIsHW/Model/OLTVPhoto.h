//
//  OLTVPhoto.h
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 07/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OLTVPhoto : NSObject

@property (strong, nonatomic) NSString *albumID;
@property (strong, nonatomic) NSString *photoID;
@property (strong, nonatomic) NSString *ownerID;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *text;

@property (strong, nonatomic) NSNumber *height;
@property (strong, nonatomic) NSNumber *width;

@property (strong, nonatomic) NSURL *photoURL;

@property (strong, nonatomic) NSDate *date;

- (instancetype)initWithResponse:(NSDictionary *)response;

@end
