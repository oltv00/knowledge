//
//  OLTVUser.h
//  iOSDev4501_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 04/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OLTVUser : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSURL *imageURL;
- (instancetype)initWithResponseObject:(NSDictionary *)responseObject;

@end
