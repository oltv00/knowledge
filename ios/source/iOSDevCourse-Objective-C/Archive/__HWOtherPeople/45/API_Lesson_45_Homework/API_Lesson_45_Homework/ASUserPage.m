//
//  ASUserPage.m
//  API_Lesson_45_Homework
//
//

#import "ASUserPage.h"

@implementation ASUserPage

-(id) initWithServerResponse: (NSDictionary*) responseObject
{
    self = [super init];
    if (self) {
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        
        self.userIds = [responseObject objectForKey:@"uid"];
        
        self.city = [responseObject objectForKey:@"bdate"];
        
        self.isOnline = [responseObject objectForKey:@"online"];
        
        NSString* urlString = [responseObject objectForKey:@"photo_100"];
        
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        }
        
    }
    return self;
}

@end

