//
//  Warehouse.m
//  ObjCTDD
//
//  Created by Oleg Tverdokhleb on 20/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "Warehouse.h"

@interface Warehouse()
@property (strong, nonatomic) NSMutableArray <Candy *>* candies;
@end

@implementation Warehouse

- (instancetype)init {
  self = [super init];
  if (self) {
    self.candies = [NSMutableArray array];
  }
  return self;
}

- (BOOL)canPick:(NSUInteger)amount {
  return amount <= self.candies.count;
}

- (void)put:(NSArray<Candy *> *)candies {
  [self.candies addObjectsFromArray:candies];
}

- (NSArray <Candy *>*)pick:(NSUInteger)amount {
  if (![self canPick:amount]) {
    return nil;
  }
  
  NSRange range = NSMakeRange(0, amount);
  NSArray *output = [self.candies subarrayWithRange:range];
  [self.candies removeObjectsInRange:range];
  
  return output;
}

@end
