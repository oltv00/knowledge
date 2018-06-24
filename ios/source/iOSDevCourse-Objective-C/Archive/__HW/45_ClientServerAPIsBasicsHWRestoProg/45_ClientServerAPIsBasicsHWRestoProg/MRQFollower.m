//
//  MRQFollower.m
//  45_ClientServerAPIsBasicsHWRestoProg
//
//  Created by Oleg Tverdokhleb on 22.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQFollower.h"

@implementation MRQFollower

- (instancetype)initWithServerResponse:(NSDictionary *) responseObject
{
    self = [super init];
    if (self) {

        self.userID = [responseObject objectForKey:@"uid"];
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        
        NSString *urlString = [responseObject objectForKey:@"photo_50"];
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        }
        
    }
    return self;
}

@end
