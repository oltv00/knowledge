//
//  ASCar.h
//  CoreDataTest
//
//  Created by Oleksii Skutarenko on 01.02.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ASObject.h"

@class ASStudent;

@interface ASCar : ASObject

@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) ASStudent *owner;

@end
