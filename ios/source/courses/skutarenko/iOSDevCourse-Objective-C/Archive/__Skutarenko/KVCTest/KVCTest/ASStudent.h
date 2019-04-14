//
//  ASStudent.h
//  KVCTest
//
//  Created by Oleksii Skutarenko on 25.01.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASStudent : NSObject

@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) NSInteger age;

- (void) changeName;

@end
