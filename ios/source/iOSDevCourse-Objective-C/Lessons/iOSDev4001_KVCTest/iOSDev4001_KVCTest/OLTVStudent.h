//
//  OLTVStudent.h
//  iOSDev4001_KVCTest
//
//  Created by Oleg Tverdokhleb on 16/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OLTVStudent : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;

- (void)changeName;

@end
