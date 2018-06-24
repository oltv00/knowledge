//
//  OLTVUser.h
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 19/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OLTVUser : NSObject

@property (strong, nonatomic) NSString *first_name;
@property (strong, nonatomic) NSString *last_name;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSURL *photoURL;

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject;

@end
