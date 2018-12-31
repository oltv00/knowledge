//
//  OLTVWall.h
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 19/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OLTVUser;

@interface OLTVPost : NSObject

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *from_id;
@property (strong, nonatomic) NSString *owner_id;
@property (strong, nonatomic) NSString *post_id;

@property (strong, nonatomic) NSNumber *likesCount;
@property (strong, nonatomic) NSNumber *commentsCount;

@property (strong, nonatomic) NSDate *date;

@property (strong, nonatomic) OLTVUser *user;

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject;
- (NSString *)stringFromDate:(NSDate *)date;

@end
