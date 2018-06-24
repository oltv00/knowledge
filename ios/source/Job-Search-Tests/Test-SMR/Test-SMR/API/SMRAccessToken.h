//
//  SMRAccessToken.h
//  Test-centr-delovih-innovacii
//
//  Created by Oleg Tverdokhleb on 11/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMRAccessToken : NSObject <NSCoding>

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *token_type;
@property (strong, nonatomic) NSDate *expires_in;

- (instancetype)initWithResponse:(NSDictionary *)response;

@end
