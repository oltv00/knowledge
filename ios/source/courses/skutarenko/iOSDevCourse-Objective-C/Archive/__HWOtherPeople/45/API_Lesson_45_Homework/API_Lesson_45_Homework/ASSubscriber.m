//
//  ASSubscriber.m
//  API_Lesson_45_Homework
//
//

#import "ASSubscriber.h"

@implementation ASSubscriber


-(id) initWithServerResponse: (NSDictionary*) responseObject
{
    self = [super init];
    if (self) {
        
        self.name = [responseObject objectForKey:@"name"];
        
        self.subId = [responseObject objectForKey:@"id"];
                
        NSString* urlString = [responseObject objectForKey:@"photo_50"];
        
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        }
        
    }
    return self;
}




@end
