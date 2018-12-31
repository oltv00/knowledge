//
//  OLTVGroup.h
//  iOSDev4501_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 05/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OLTVGroup : NSObject

@property (strong, nonatomic) NSString *gid;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSURL *imageURL;
- (instancetype)initWithResponseObject:(NSDictionary *)responseObject;

@end
