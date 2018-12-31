//
//  MRQObject.m
//  41_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 31.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQObject.h"

@implementation MRQObject

// Insert code here to add functionality to your managed object subclass

- (BOOL)validateForDelete:(NSError **)error {

    NSLog(@"MRQObject validateForDelete");
    
    return YES;
}

@end
