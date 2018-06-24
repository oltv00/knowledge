//
//  Student.h
//  40_KVCTest
//
//  Created by Oleg Tverdokhleb on 26.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;

- (void) changeNameProperty;
- (void) changeNameWithIvar;

@end
