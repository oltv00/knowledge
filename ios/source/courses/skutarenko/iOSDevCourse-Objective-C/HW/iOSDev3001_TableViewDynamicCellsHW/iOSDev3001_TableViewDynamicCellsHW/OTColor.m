//
//  OTColor.m
//  iOSDev3001_TableViewDynamicCellsHW
//
//  Created by Oleg Tverdokhleb on 24.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTColor.h"

@implementation OTColor

+ (NSArray *)initColorsWithCount:(NSInteger)count {
  NSMutableArray *array = [NSMutableArray array];
  
  for (int i = 0; i < count; i += 1) {
    OTColor *object = [[OTColor alloc] init];
    
    CGFloat rVal = (CGFloat)arc4random_uniform(255) / 256;
    CGFloat gVal = (CGFloat)arc4random_uniform(255) / 256;
    CGFloat bVal = (CGFloat)arc4random_uniform(255) / 256;
    
    object.color = [UIColor colorWithRed:rVal green:gVal blue:bVal alpha:1.0f];
    object.name = [NSString stringWithFormat:@"RGB: {%.0f %.0f %.0f}", rVal*256, gVal*256, bVal*256];
    
    [array addObject:object];
  }
  
  NSArray *resultArray = [NSArray arrayWithArray:array];
  return resultArray;
}

@end
