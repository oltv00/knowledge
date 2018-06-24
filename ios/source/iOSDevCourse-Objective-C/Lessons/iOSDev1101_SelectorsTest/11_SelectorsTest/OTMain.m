//
//  OTMain.m
//  11_SelectorsTest
//
//  Created by Oleg Tverdokhleb on 04.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTMain.h"
#import "OTObject.h"

@interface OTMain ()

@property (assign, nonatomic) SEL sel;

@end

@implementation OTMain

- (void)main {
//    [self first];
//    [self two];
//    [self three];
//    [self four];
    [self five];
}

#pragma mark - Tests

- (void)five {
    SEL selector = @selector(testMethodWithParam:param2:param3:);
    NSMethodSignature *signature = [OTMain instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    [invocation setTarget:self];        //INDEX 1
    [invocation setSelector:selector];  //INDEX 2
    
    NSInteger iVal = 5;
    CGFloat fVal = 3.1f;
    double dVal = 5.5f;
    
    NSInteger *p1 = &iVal;
    CGFloat *p2 = &fVal;
    double *p3 = &dVal;
    
    [invocation setArgument:p1 atIndex:2]; //INDEX 3 for arguments
    [invocation setArgument:p2 atIndex:3];
    [invocation setArgument:p3 atIndex:4];
    
    [invocation invoke];
    
    __unsafe_unretained NSString *string = nil;
    //NSString **p4 = &string;
    [invocation getReturnValue:&string]; //p4
    
    NSLog(@"%@", string);
}

- (void)four {
    NSString *string = [self testMethodWithParam:2 param2:3.1 param3:5.5];
    NSLog(@"string = %@", string);;
}

- (void)three {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    
    NSString *selString = NSStringFromSelector(@selector(testMethod));
    SEL sel = NSSelectorFromString(selString);
    [self performSelector:sel];
    [self performSelector:NSSelectorFromString(selString)];
    
#pragma clang diagnostic pop
}

- (void)two {
    [self testNumbers:5];
    [self performSelector:@selector(testNumbers:) withObject:@(5)];
    [self performSelector:@selector(testNumbers:) withObject:@[@(5)]];
}

- (void)first {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

    OTObject *obj = [OTObject new];
    
        SEL sel1 = @selector(testMethod);
        SEL sel2 = @selector(testMethodWithParam:);
        SEL sel3 = @selector(testMethodWithParam:param2:);
    
        [self performSelector:sel1];
        [obj performSelector:sel1];
        [self performSelector:sel2 withObject:@"TEST OBJECT"];
        [self performSelector:sel3 withObject:@"FIRST OBJECT" withObject:@"SECOND OBJECT"];
    
#pragma clang diagnostic pop
}

#pragma mark - Help methods

- (NSString *)testMethodWithParam:(NSInteger)intValue param2:(CGFloat)floatValue param3:(double)doubleValue {
    return [NSString stringWithFormat:
            @"testMethodWithParam1 %ld param2: %f, param3 :%f",
            intValue, floatValue, doubleValue];
}


- (void)testNumbers:(NSInteger) number {
    NSLog(@"number = %ld", number);
}

- (void)testMethodWithParam:(NSString *) string param2:(NSString *) string2 {
    NSLog(@"testMethodWithParam:param2: %@ %@", string, string2);
}

- (void)testMethodWithParam:(NSString *) string {
    NSLog(@"testMethodWithParam: %@", string);
}

- (void)testMethod {
    NSLog(@"testMethod");
}

@end
