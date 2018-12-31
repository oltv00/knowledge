//
//  MRQStudent.h
//  13_ThreadsTestRestoProg
//
//  Created by Oleg Tverdokhleb on 25.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRQStudent : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger studentAnswer;

- (void) guessTheAnswer:(NSInteger) intValue studentAnswer:(NSInteger) studentAnswer;

@end
