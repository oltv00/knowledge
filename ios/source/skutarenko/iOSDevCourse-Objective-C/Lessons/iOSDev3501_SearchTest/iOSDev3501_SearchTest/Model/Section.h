//
//  Section.h
//  iOSDev3501_SearchTest
//
//  Created by Oleg Tverdokhleb on 01.05.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Section : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *items;

@end
