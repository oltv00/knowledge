//
//  ASPost.m
//  APITest
//
//  Created by Oleksii Skutarenko on 14.03.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import "ASPost.h"

@implementation ASPost

- (id) initWithServerResponse:(NSDictionary*) responseObject
{
    self = [super initWithServerResponse:responseObject];
    if (self) {
        self.text = [responseObject objectForKey:@"text"];
        self.text = [self.text stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    }
    return self;
}

@end
