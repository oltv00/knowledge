//
//  MRQSubscriptor.h
//  45_ClientServerAPIsBasicsHWRestoProg
//
//  Created by Oleg Tverdokhleb on 23.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRQSubscriptor : NSObject

@property (strong, nonatomic) NSNumber *userID;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSURL *imageURL;

- (id)initWithServerResponse:(NSDictionary *) responseObject;

@end
