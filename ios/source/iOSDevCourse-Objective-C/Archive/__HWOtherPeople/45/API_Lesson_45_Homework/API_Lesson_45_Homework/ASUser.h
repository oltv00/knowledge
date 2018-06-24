//
//  ASUser.h
//  API_Lesson_45_Homework
//
//

#import <Foundation/Foundation.h>

@interface ASUser : NSObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSURL* imageURL;
@property (strong, nonatomic) NSString* userId;
@property (strong, nonatomic) NSString* isOnline;

-(id) initWithServerResponse: (NSDictionary*) responseObject;

@end
