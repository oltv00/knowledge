//
//  ASFollower.h
//  API_Lesson_45_Homework
//
//

#import <Foundation/Foundation.h>

@interface ASFollower : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSURL* imageURL;
@property (strong, nonatomic) NSString* subId;

-(id) initWithServerResponse: (NSDictionary*) responseObject;



@end
