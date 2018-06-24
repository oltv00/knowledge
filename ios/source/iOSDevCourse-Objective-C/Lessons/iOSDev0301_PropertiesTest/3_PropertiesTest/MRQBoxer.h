//
//  MRQBoxer.h
//  3_PropertiesTest
//
//  Created by Oleg Tverdokhleb on 02.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface MRQBoxer : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat weight;

- (instancetype)initWithDefaultParameters;
- (NSInteger)howOldAreYouWithGetter;
- (NSInteger)howOldAreYouWithoutGetter;

@end
