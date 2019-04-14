//
//  Block.h
//  Lesson1
//
//  Created by Oleg Tverdokhleb on 13.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BlockWithoutParam)(void);
typedef void(^BlockWithParam)(NSString*);
typedef NSString*(^BlockWithReturnParam)(void);
typedef NSString*(^BlockWithParamAndReturnParam)(NSString*);

@interface Block : NSObject

@property (copy, nonatomic) BlockWithoutParam blockWithoutParam;
@property (copy, nonatomic) BlockWithParam blockWithParam;
@property (copy, nonatomic) BlockWithReturnParam blockWithReturnParam;
@property (copy, nonatomic) BlockWithParamAndReturnParam blockWithParamAndReturnParam;

@end
