//
//  ASFollower.m
//  API_Lesson_45_Homework
//
//

#import "ASFollower.h"

@implementation ASFollower

-(id) initWithServerResponse: (NSDictionary*) responseObject
{
    self = [super init];
    if (self) {
        
        self.name = [NSString stringWithFormat:@"%@ %@", [responseObject objectForKey:@"first_name"], [responseObject objectForKey:@"last_name"]];
                
        self.subId = [responseObject objectForKey:@"id"];
        
        NSString* urlString = [responseObject objectForKey:@"photo_50"];
        
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        }
        
    }

    return self;
}


@end
