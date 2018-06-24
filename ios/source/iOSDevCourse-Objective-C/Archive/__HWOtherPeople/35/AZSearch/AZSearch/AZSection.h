//
//  AZSection.h
//  AZSearch
//
//  Created by Alex Alexandrov on 12.02.14.
//  Copyright (c) 2014 Alex Zbirnik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZSection : NSObject

@property (strong, nonatomic) NSString *sectionName;
@property (strong, nonatomic) NSMutableArray *sectionObjectsArray;

- (void) sortByNameAndFamaly;

@end
