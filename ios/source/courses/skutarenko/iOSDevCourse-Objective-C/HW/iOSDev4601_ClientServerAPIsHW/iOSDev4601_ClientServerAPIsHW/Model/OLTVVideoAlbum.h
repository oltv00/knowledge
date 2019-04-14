//
//  OLTVVideoAlbum.h
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 11/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OLTVVideoAlbum : NSObject

@property (strong, nonatomic) NSString *albumID;
@property (strong, nonatomic) NSString *ownerID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *count;

@property (strong, nonatomic) NSURL *photoURL;

- (instancetype)initWithResponseObject:(NSDictionary *)response;

@end
