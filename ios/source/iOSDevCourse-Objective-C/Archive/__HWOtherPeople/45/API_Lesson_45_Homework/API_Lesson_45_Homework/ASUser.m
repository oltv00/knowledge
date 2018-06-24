//
//  ASUser.m
//  API_Lesson_45_Homework
//
//

#import "ASUser.h"

@implementation ASUser

-(id) initWithServerResponse: (NSDictionary*) responseObject
{
    self = [super init];
    if (self) {
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        
        self.userId = [responseObject objectForKey:@"user_id"];
        
        self.isOnline = [responseObject objectForKey:@"online"];
        
        NSString* urlString = [responseObject objectForKey:@"photo_50"];
        
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        }
        
    }
    return self;
}







@end
