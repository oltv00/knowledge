//
//  MRQHuman.h
//  5_ArraysTestRestoProg
//
//  Created by Oleg Tverdokhleb on 01.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    man,
    woman
} gender;

@interface MRQHuman : NSObject

@property (strong, nonatomic) NSString *theScopeOfPractice;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat weight;
@property (assign, nonatomic) gender gender;

- (void) movement;
- (void) conclusion;

@end
