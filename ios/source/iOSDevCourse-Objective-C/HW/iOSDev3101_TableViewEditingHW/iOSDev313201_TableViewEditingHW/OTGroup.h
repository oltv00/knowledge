//
//  OTGroup.h
//  iOSDev313201_TableViewEditingHW
//
//  Created by Oleg Tverdokhleb on 26.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OTStudent;

@interface OTGroup : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger count;
@property (strong, nonatomic) NSArray <OTStudent *> *students;

+ (NSArray *)initWithDefaultGroups;
- (OTGroup *)initGroupWithName:(NSString *)name studentsCount:(NSInteger)count;

@end
