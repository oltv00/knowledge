//
//  OTMain.m
//  12_BlocksTest
//
//  Created by Oleg Tverdokhleb on 05.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTMain.h"
#import "OTObject.h"

typedef void(^Block)(void);
typedef NSString *(^BlockWithParam)(NSInteger intValue);

@interface OTMain ()

@property (copy, nonatomic) Block block;
@property (strong, nonatomic) NSString *name;

@end

@implementation OTMain

+ (OTMain *)sharedMain {
    static OTMain *main = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        main = [OTMain new];
    });
    return main;
}

- (void)dealloc {
    NSLog(@"%@ is deallocated", self);
}

- (void)main {
    //(return type)(^block name)(type of the take variable) = ^(type of take variable and name) {};
    
//    [self one];
//    [self two];
//    [self three];
//    [self four];
//    [self five];
//    [self six];
//    [self seven];
//    [self eight];
//    [self nine];
//    [self ten];
//    [self eleven];
    [self twelve];
}

- (void)twelve {
    self.name = @"Hello";
    
    OTObject *obj = [OTObject new];
    obj.name = @"OBJECT";
}

- (void)eleven {
    self.name = @"Hello";
    
    OTObject *obj = [OTObject new];
    obj.name = @"OBJECT";
    
    [obj method:^{
        NSLog(@"%@", self.name);
    }];
}

- (void)ten {
    OTObject *strongObject = [OTObject new];
    OTObject *weakObject = [OTObject new];
    __weak OTObject *weakReference = weakObject;
    
    strongObject.name = @"STRONG OBJECT";
    weakObject.name = @"WEAK OBJECT";
    
    Block block = ^{
        NSLog(@"I'am %@ with my class %@ and super class %@",
              strongObject.name, [strongObject class], [strongObject superclass]);
        NSLog(@"I'am %@ with my class %@ and super class %@",
              weakReference.name, [weakReference class], [weakReference superclass]);
    };
//    block();
    self.block = block;
    self.block();
}

- (void)nine {
    [self nineAdd:^NSString *(NSInteger intValue) {
        return [NSString stringWithFormat:@"%ld", intValue];
    }];
}

- (void)nineAdd:(BlockWithParam)block {
    NSLog(@"%@", block(5));
}

- (void)eight {
    BlockWithParam block = ^(NSInteger intValue) {
        return [NSString stringWithFormat:@"%ld", intValue];
    };
    NSString *string = block(5);
    NSLog(@"result = %@", string);
    
    [self nineAdd:block];
}

- (void)seven {
    //typedef identifier
    Block block = ^() {
        NSLog(@"block with identifier");
    };
    block();
}

- (void)six {
    [self methodWithBlock:^{
        NSLog(@"BLOCK!!!");
    }];
}

- (void)methodWithBlock:(void(^)(void)) block {
    NSLog(@"methodWithBlock");
    block();
    block();
}

- (void)five {
    __block NSString *string = @"How is it possible?";
    __block NSInteger index = 0;
    void(^block)(void) = ^{
        NSLog(@"block call");
        string = [NSString stringWithFormat:@"%@ %ld", string, index];
        NSLog(@"%@", string);
        NSLog(@"block call is %ld times", ++index);
    };
    while (index < 10) {
        block();
    }
    
    NSLog(@"RESULT STRING = %@", string);
    NSLog(@"RESULT INTVALUE = %ld", index);
}

- (void)four {
    //block with return value and params
    NSString *(^blockWithReturnValueAndParams)(NSString *, NSInteger);
    blockWithReturnValueAndParams = ^(NSString *string, NSInteger intValue) {
        return [NSString stringWithFormat:@"str = %@, val = %ld", string, intValue];
    };
    NSLog(@"%@", blockWithReturnValueAndParams(@"TEST STRING", 123));
}

- (void)three {
    //block with return value
    NSString *(^blockWithReturnValue)() = ^() {
        return @"blockWithReturnValue";
    };
    NSLog(@"%@", blockWithReturnValue());
}

- (void)two {
    //block with params
    void(^blockWithParams)(NSString *, NSInteger) = ^(NSString *string, NSInteger intValue){
        NSLog(@"testBlockWithParams %@ %ld", string, intValue);
    };
    blockWithParams(@"TEST STRING", 111);
}

- (void)one {
    //block without return type and params
    
    //ad block
    void(^block)(void);
    
    //initialization block
    block = ^{
        NSLog(@"Test block called");
    };
    
    //call block;
    block();
}

@end
