//
//  OLTVGroup.h
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 05/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OLTVGroupMenu : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *count;
@end

@interface OLTVGroup : NSObject

@property (strong, nonatomic) NSString *groupID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *descrip;
@property (strong, nonatomic) NSString *site;
@property (strong, nonatomic) NSMutableArray *menu;

@property (strong, nonatomic) NSURL *photoURL;

- (instancetype)initWithResponseObject:(NSDictionary *)responseObject;

@end


