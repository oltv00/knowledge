//
//  OTStudent.m
//  13_ThreadsHW
//
//  Created by Oleg Tverdokhleb on 07.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTStudent.h"
#import "Data.h"

typedef void(^ResultBlock)(OTStudent *student, double endTime);

@interface OTStudent ()

@property (copy, nonatomic) ResultBlock resultBlock;


@end

@implementation OTStudent

+ (dispatch_queue_t)sharedQueue {
    static dispatch_queue_t queue;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        queue = dispatch_queue_create("com.oltv00.threadstest.students", DISPATCH_QUEUE_CONCURRENT);
    });
    return queue;
}

+ (NSOperationQueue *)sharedOperationQueue {
    static NSOperationQueue *queue = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        queue = [[NSOperationQueue alloc] init];
    });
    return queue;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = firstNames[arc4random_uniform(50)];
        self.lastName = lastNames[arc4random_uniform(50)];
        self.attempts = 0;
    }
    return self;
}

- (void)dealloc {
//    NSLog(@"%@ is deallocated", self);
}

- (void)levelSupermanGuessAnswerWithBlock:(NSInteger)correctAnswer
                                      min:(unsigned int)min
                                      max:(unsigned int)max
                                   result:(void(^)(OTStudent *student, double endTime))result {
    __weak OTStudent *weakSelf = self;
    [[OTStudent sharedOperationQueue] addOperationWithBlock:^{
        double startTime = CACurrentMediaTime();
        NSInteger randomAnswer = 0;
        NSInteger timeToInfo = 0;
        do {
            self.attempts += 1;
            timeToInfo += 1;
            randomAnswer = min + arc4random_uniform(max);
            
            if (timeToInfo == 5000) {
                timeToInfo = 0;
            }
            
        } while (randomAnswer != correctAnswer);
        double endTime = CACurrentMediaTime() - startTime;
        result(weakSelf, endTime);
    }];
}

- (void)levelSupermanGuessAnswerWithInvocationMethod:(NSDictionary *)params
                                              result:(void(^)(OTStudent *student, double endTime))result {
    self.resultBlock = result;

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSOperation *operation = [[NSInvocationOperation alloc]
                              initWithTarget:self
                              selector:@selector(levelSupermanGuessAnswerWithInvocationMethodSelectorAndParams:)
                              object:params];
    
    [queue addOperation:operation];
}

- (void)levelSupermanGuessAnswerWithInvocationMethodSelectorAndParams:(NSDictionary *)params {
    NSInteger correctAnswer = [[params objectForKey:@"correctAnswer"] integerValue];
    unsigned int min = [[params objectForKey:@"min"] unsignedIntValue];
    unsigned int max = [[params objectForKey:@"max"] unsignedIntValue];
    
    double startTime = CACurrentMediaTime();
    NSInteger randomAnswer = 0;
    NSInteger timeToInfo = 0;
    do {
        self.attempts += 1;
        timeToInfo += 1;
        randomAnswer = min + arc4random_uniform(max);
        
        if (timeToInfo == 5000) {
            timeToInfo = 0;
//            double middleTime = CACurrentMediaTime() - startTime;
//            NSLog(@"%@ attempts %ld and spent time %f", self.name, self.attempts, middleTime);
        }
        
    } while (randomAnswer != correctAnswer);
    
    double endTime = CACurrentMediaTime() - startTime;
    self.resultBlock(self, endTime);
}

- (void)levelMasterGuessAnswer:(NSInteger)correctAnswer
                            min:(unsigned int)min
                            max:(unsigned int)max
                         result:(void(^)(OTStudent *student, double endTime))result {
    dispatch_async([OTStudent sharedQueue], ^{
        double startTime = CACurrentMediaTime();
        NSInteger randomAnswer = 0;
        NSInteger timeToInfo = 0;
        do {
            self.attempts += 1;
            timeToInfo += 1;
            randomAnswer = min + arc4random_uniform(max);
            
            if (timeToInfo == 5000) {
                timeToInfo = 0;
//                double middleTime = CACurrentMediaTime() - startTime;
//                NSLog(@"%@ attempts %ld and spent time %f", self.name, self.attempts, middleTime);
            }
            
        } while (randomAnswer != correctAnswer);
        double endTime = CACurrentMediaTime() - startTime;
        
        __weak OTStudent *weakStudent = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            result(weakStudent, endTime);
        });
    });
}

- (void)levelStudentGuessAnswer:(NSInteger)correctAnswer
                            min:(unsigned int)min
                            max:(unsigned int)max
                         result:(void(^)(OTStudent *student, double endTime))result {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        double startTime = CACurrentMediaTime();
        NSInteger randomAnswer = 0;
        NSInteger timeToInfo = 0;
        do {
            self.attempts += 1;
            timeToInfo += 1;
            randomAnswer = min + arc4random_uniform(max);
            
            if (timeToInfo == 5000) {
                timeToInfo = 0;
//                double middleTime = CACurrentMediaTime() - startTime;
//                NSLog(@"%@ attempts %ld and spent time %f", self.name, self.attempts, middleTime);
            }
            
        } while (randomAnswer != correctAnswer);
        double endTime = CACurrentMediaTime() - startTime;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            __weak OTStudent *weakStudent = self;
            result(weakStudent, endTime);
        });
    });
}

- (void)levelNoobGuessAnswer:(NSInteger)correctAnswer min:(unsigned int)min max:(unsigned int)max {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        double startTime = CACurrentMediaTime();
        NSInteger randomAnswer = 0;
        NSInteger timeToInfo = 0;
        do {
            self.attempts += 1;
            timeToInfo += 1;
            randomAnswer = min + arc4random_uniform(max);
            
            if (timeToInfo == 5000) {
                timeToInfo = 0;
                double middleTime = CACurrentMediaTime() - startTime;
                NSLog(@"%@ attempts %ld and spent time %f", self.name, self.attempts, middleTime);
            }
            
        } while (randomAnswer != correctAnswer);
        double endTime = CACurrentMediaTime() - startTime;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"-------------------------------");
            NSLog(@"%@ gave the correct answer", self.name);
            NSLog(@"%@ attempts %ld and spent time %f", self.name, self.attempts, endTime);
            NSLog(@"-------------------------------");
        });
    });
}

@end
