//
//  AZSection.m
//  AZSearch
//
//  Created by Alex Alexandrov on 12.02.14.
//  Copyright (c) 2014 Alex Zbirnik. All rights reserved.
//

#import "AZSection.h"

@implementation AZSection

- (id)init
{
    self = [super init];
    if (self) {
        
        self.sectionObjectsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) sortByNameAndFamaly {
    
    NSSortDescriptor *firstName = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor *lastName = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    NSArray *sortDescription = [[NSMutableArray alloc] initWithObjects: firstName, lastName, nil];
    
    [self.sectionObjectsArray sortUsingDescriptors:sortDescription];
}


@end
