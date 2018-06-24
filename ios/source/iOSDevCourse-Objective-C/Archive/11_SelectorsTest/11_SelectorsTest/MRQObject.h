//
//  MRQObject.h
//  11_SelectorsTest
//
//  Created by Oleg Tverdokhleb on 22.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRQObject : NSObject

@property (assign, nonatomic) SEL sel; // тип только assign!

- (void) testMethod;

@end
