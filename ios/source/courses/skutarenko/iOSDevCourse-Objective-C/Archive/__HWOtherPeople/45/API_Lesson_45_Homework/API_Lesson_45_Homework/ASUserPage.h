//
//  ASUserPage.h
//  API_Lesson_45_Homework
//
//

#import <Foundation/Foundation.h>

@interface ASUserPage : NSObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSURL* imageURL;
@property (strong, nonatomic) NSString* userIds;
@property (strong, nonatomic) NSString* isOnline;
@property (strong, nonatomic) NSString* city;

-(id) initWithServerResponse: (NSDictionary*) responseObject;


@end
