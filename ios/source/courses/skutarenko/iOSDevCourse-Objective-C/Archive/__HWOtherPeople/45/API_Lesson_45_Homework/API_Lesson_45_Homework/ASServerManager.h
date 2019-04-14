//
//  ASServerManager.h
//  API_Lesson_45_Homework
//
//

#import <Foundation/Foundation.h>

@interface ASServerManager : NSObject


+(ASServerManager*) sharedManager;

-(void) getFriendsWithOffset: (NSInteger) offset
                       count: (NSInteger) count
                   onSuccess: (void (^) (NSArray* friends)) success
                   onFailure: (void (^) (NSError* error, NSInteger statusCode)) failure;

-(void) getUserPageWithID: (NSInteger) userID
                   onSuccess: (void (^) (NSArray* userData)) success
                   onFailure: (void (^) (NSError* error, NSInteger statusCode)) failure;


-(void) getSubscriberOfUserWithID: (NSInteger) userID
                           offset: (NSInteger) offset
                            count: (NSInteger) count
                        onSuccess: (void (^) (NSArray* subscribers, NSInteger count)) success
                        onFailure: (void (^) (NSError* error, NSInteger statusCode)) failure;

-(void) getFollowersOfUserWithID: (NSInteger) userID
                          offset: (NSInteger) offset
                           count: (NSInteger) count
                       onSuccess: (void (^) (NSArray* followers, NSInteger count)) success
                       onFailure: (void (^) (NSError* error, NSInteger statusCode)) failure;


@end
