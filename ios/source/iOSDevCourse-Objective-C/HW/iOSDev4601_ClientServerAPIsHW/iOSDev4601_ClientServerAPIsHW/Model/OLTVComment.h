//
//  OLTVComment.h
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 29/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OLTVUser;

@interface OLTVComment : NSObject

@property (strong, nonatomic) NSDate *date;

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *from_id;
@property (strong, nonatomic) NSString *commentID;

@property (strong, nonatomic) OLTVUser *user;

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject;
- (NSString *)stringFromDate:(NSDate *)date;

@end
