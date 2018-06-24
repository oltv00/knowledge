//
//  Warehouse.h
//  ObjCTDD
//
//  Created by Oleg Tverdokhleb on 20/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Candy;

@interface Warehouse : NSObject

@property (strong, nonatomic, readonly) NSMutableArray <Candy *>* candies;

- (void)put:(NSArray <Candy *>*)candies;
- (NSArray <Candy *>*)pick:(NSUInteger)amount;
- (BOOL)canPick:(NSUInteger)amount;

@end
