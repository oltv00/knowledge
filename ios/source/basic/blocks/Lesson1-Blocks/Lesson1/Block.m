//
//  Block.m
//  Lesson1
//
//  Created by Oleg Tverdokhleb on 13.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "Block.h"

@implementation Block

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self createBlocks];
        [self callBlocks];
        
    }
    return self;
}

- (void)callBlocks {
    
    self.blockWithoutParam();
    self.blockWithParam(@"param");
    NSLog(@"%@", self.blockWithReturnParam);
    NSLog(@"%@", self.blockWithParamAndReturnParam(@"return param"));
}

- (void)createBlocks {
    
    void(^blockWithoutParam)(void) = ^(){
        NSLog(@"I am block");
    };
    self.blockWithoutParam = blockWithoutParam;
    
    void(^blockWithParam)(NSString*) = ^(NSString *string) {
        
        NSLog(@"Param string:%@", string);
    };
    self.blockWithParam = blockWithParam;
    
    NSString* (^blockWithReturnParam)(void) = ^(){
        
        return [NSString stringWithFormat:@"Return string"];
    };
    self.blockWithReturnParam = blockWithReturnParam;
    
    NSString * (^blockWithParamAndReturnParam)(NSString*) = ^(NSString *string){
        
        return string;
    };
    self.blockWithParamAndReturnParam = blockWithParamAndReturnParam;
}

@end
