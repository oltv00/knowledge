//
//  OTStudent.h
//  13_ThreadsHW
//
//  Created by Oleg Tverdokhleb on 07.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OTStudent : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) NSInteger attempts;

- (void)levelNoobGuessAnswer:(NSInteger) correctAnswer min:(unsigned int) min max:(unsigned int) max;

- (void)levelStudentGuessAnswer:(NSInteger) correctAnswer
                            min:(unsigned int)min
                            max:(unsigned int)max
                         result:(void(^)(OTStudent *student, double endTime))result;

- (void)levelMasterGuessAnswer:(NSInteger)correctAnswer
                           min:(unsigned int)min
                           max:(unsigned int)max
                        result:(void(^)(OTStudent *student, double endTime))result;

- (void)levelSupermanGuessAnswerWithInvocationMethod:(NSDictionary *)params
                                              result:(void(^)(OTStudent *student, double endTime))result;

- (void)levelSupermanGuessAnswerWithBlock:(NSInteger)correctAnswer
                                      min:(unsigned int)min
                                      max:(unsigned int)max
                                   result:(void(^)(OTStudent *student, double endTime))result;

@end
