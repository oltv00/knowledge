//
//  MRQDetailedUser.h
//  45_ClientServerAPIsBasicsHWRestoProg
//
//  Created by Oleg Tverdokhleb on 18.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRQDetailedUser : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) NSNumber *followersCount;
@property (strong, nonatomic) NSURL *imageURL;

- (id)initWithServerResponse:(NSDictionary *) responseObject;

@end
