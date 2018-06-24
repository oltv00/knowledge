//
//  main.m
//  Pattern
//
//  Created by Oleg Tverdokhleb on 17/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FactoryMethod.h"

BOOL isRunning = YES;

void factory_method();

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    factory_method();
    
    //[[NSRunLoop currentRunLoop] run];
  }
    return 0;
}

void factory_method() {
  Factory *factory = [Factory new];
  for (NSInteger i = 0; i < 200; i += 20) {
    [factory saveExpenses:i];
  }
}




