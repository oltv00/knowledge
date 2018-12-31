//
//  OLTVMessage.h
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 21/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, OLTVMessageType) {
  OLTVMessageTypeMine = 1,
  OLTVMessageTypeYour = 2
};

@interface OLTVMessage : NSObject

@property (strong, nonatomic) NSArray *messageID;
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSNumber *from_id;
@property (assign, nonatomic) OLTVMessageType type;

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject;

@end
