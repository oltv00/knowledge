//
//  MRQAccessToken.h
//  46-47_ClientServerAPIs
//
//  Created by Oleg Tverdokhleb on 24.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRQAccessToken : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSDate *expiresDate;

@end
