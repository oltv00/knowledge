//
//  MRQUser.h
//  45_ClientServerAPIsBasicsHWRestoProg
//
//  Created by Oleg Tverdokhleb on 17.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRQUser : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSNumber *uid;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSURL *imageURL;

- (id)initWithServerResponse:(NSDictionary *) responseObject;

@end
