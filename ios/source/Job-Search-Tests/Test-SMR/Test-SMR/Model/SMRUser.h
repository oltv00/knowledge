//
//  SMRUser.h
//  Test-centr-delovih-innovacii
//
//  Created by Oleg Tverdokhleb on 11/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMRUser : NSObject <NSCoding>

@property (strong, nonatomic) NSNumber *user_id;

- (instancetype)initWithResponse:(NSDictionary *)response;

@end
