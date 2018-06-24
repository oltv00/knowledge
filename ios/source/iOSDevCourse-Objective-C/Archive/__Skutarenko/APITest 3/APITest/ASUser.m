//
//  ASUser.m
//  APITest
//
//  Created by Oleksii Skutarenko on 20.02.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import "ASUser.h"

@implementation ASUser

- (id) initWithServerResponse:(NSDictionary*) responseObject
{
    self = [super initWithServerResponse:responseObject];
    if (self) {
        
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        
        NSString* urlString = [responseObject objectForKey:@"photo_50"];
        
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        }
    }
    return self;
}


@end
