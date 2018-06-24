//
//  OLTVVideo.h
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 13/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OLTVVideo : NSObject


@property (strong, nonatomic) NSString *descrip;
@property (strong, nonatomic) NSString *videoID;
@property (strong, nonatomic) NSString *ownerID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *views;
@property (strong, nonatomic) NSString *duration;
@property (strong, nonatomic) NSString *comments;
@property (strong, nonatomic) NSString *likes;

@property (strong, nonatomic) NSURL *photoURL;
@property (strong, nonatomic) NSURL *videoURL;

- (instancetype)initWithResponseObject:(NSDictionary *)response;

@end
