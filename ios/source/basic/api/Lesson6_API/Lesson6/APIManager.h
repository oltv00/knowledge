//
//  APIManager.h
//  Lesson6
//
//  Created by Oleg Tverdokhleb on 24.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIManagerDelegate;

@interface APIManager : NSObject

+ (APIManager *) sharedManager;

+ (APIManager *) managerWithDelegate:(id <APIManagerDelegate>)aDelegate;
@property (weak, nonatomic) id <APIManagerDelegate> delegate;

- (void)getRandomAdvice;

@end

@protocol APIManagerDelegate <NSObject>

@required
- (void)getAdvice:(NSDictionary *) advice;

@end