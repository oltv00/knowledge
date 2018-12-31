//
//  OTAnimal.h
//  5_Arrays
//
//  Created by Oleg Tverdokhleb on 29.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OTAnimal : NSObject

@property (strong, nonatomic) NSString *breed;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat weight;

- (instancetype)initWithName:(NSString *) breed Index:(NSInteger)index;
- (void)move;

@end
