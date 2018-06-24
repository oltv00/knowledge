//
//  ASStudent.m
//  CoreDataTest
//
//  Created by Oleksii Skutarenko on 31.01.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import "ASStudent.h"


@implementation ASStudent

@dynamic firstName;
@dynamic lastName;
@dynamic dateOfBirth;
@dynamic score;

- (void) setFirstName:(NSString *)firstName {
    
    [self willChangeValueForKey:@"firstName"];
    [self setPrimitiveValue:firstName forKey:@"firstName"];
    [self didChangeValueForKey:@"firstName"];
    
    //NSLog(@"SET FIRST NAME!!!");
}

- (NSString*) firstName {
    
    NSString* string = nil;
    
    [self willAccessValueForKey:@"firstName"];
    string = [self primitiveValueForKey:@"firstName"];
    [self didAccessValueForKey:@"firstName"];
    
    //NSLog(@"GET FIRST NAME!!!");
    
    return string;
}

/*
- (BOOL) validateLastName:(__autoreleasing id *)value error:(NSError *__autoreleasing *)error {
    
    *error = [NSError errorWithDomain:@"BAD LAST NAME" code:123 userInfo:nil];
    
    return NO;
}*/


@end
