//
//  OLTVWall.h
//  iOSDev4501_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 07/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

typedef NS_ENUM(NSInteger, OLTVWallType) {
  OLTVWallTypeText,
  OLTVWallTypePhoto,
  OLTVWallTypeLink
};

@interface OLTVWall : NSObject

@property (strong, nonatomic) NSString *dateString;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *from_id;
@property (strong, nonatomic) NSString *linkTitle;
@property (strong, nonatomic) NSString *linkCaption;

@property (strong, nonatomic) NSURL *photoURL;
@property (strong, nonatomic) NSURL *linkURL;

@property (assign, nonatomic) OLTVWallType type;

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject;

@end