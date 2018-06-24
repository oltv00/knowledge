//
//  Shop.h
//  ObjCTDD
//
//  Created by Oleg Tverdokhleb on 20/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Warehouse;
@class Candy;

@interface Shop : NSObject

@property (strong, nonatomic, readonly) Warehouse *warehouse;

- (void)handleDelivery:(NSArray <Candy *>*)candies;

@end
