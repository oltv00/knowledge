//
//  Student.m
//  40_KVCTest
//
//  Created by Oleg Tverdokhleb on 26.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "Student.h"

@implementation Student

- (void) changeNameProperty {
    self.name = @"changeWithProperty";
}

- (void) changeNameWithIvar {
    [self willChangeValueForKey:@"name"];
    _name = @"changeWithIvar";
    [self didChangeValueForKey:@"name"];
}

- (void) setName:(NSString *)name {
    _name = name;
    NSLog(@"student setName: %@", name);
}

- (void) setAge:(NSInteger)age {
    _age = age;
    NSLog(@"student setAge :%ld", age);
}

- (NSString *) description {
    return [NSString stringWithFormat:@"%@ %ld", self.name, self.age];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    NSLog(@"setValue: %@ forKey: %@", value, key);
    [super setValue:value forKey:key];
}

- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"setValueForUndefinedKey");
}

- (id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"valueForUndefinedKey");
    return nil;
}

-(BOOL)validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKey:(NSString *)inKey error:(out NSError * _Nullable __autoreleasing *)outError {
    
    if ([inKey isEqualToString:@"name"]) {
        
        NSString *newName = *ioValue;
        if ([newName rangeOfString:@"1"].location != NSNotFound) {
            *outError = [[NSError alloc] initWithDomain:@"Number in string" code:1 userInfo:nil];
            return NO;
        }
    }
    
    return YES;
}

@end
