//
//  OTColor.h
//  iOSDev3001_TableViewDynamicCellsHW
//
//  Created by Oleg Tverdokhleb on 24.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OTColor : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UIColor *color;

+ (NSArray *)initColorsWithCount:(NSInteger)count;

@end
