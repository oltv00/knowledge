//
//  MRQDetailedUser.m
//  45_ClientServerAPIsBasicsHWRestoProg
//
//  Created by Oleg Tverdokhleb on 18.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQDetailedUser.h"

@implementation MRQDetailedUser

- (instancetype)initWithServerResponse:(NSDictionary *) responseObject
{
    self = [super init];
    if (self) {
        
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        self.followersCount = [responseObject objectForKey:@"followers_count"];
        
        NSString *urlString = [responseObject objectForKey:@"photo_max"];
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        }
    }
    return self;
}

@end
