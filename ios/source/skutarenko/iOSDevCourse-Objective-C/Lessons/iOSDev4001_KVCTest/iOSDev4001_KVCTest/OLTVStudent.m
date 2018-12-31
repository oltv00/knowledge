//
//  OLTVStudent.m
//  iOSDev4001_KVCTest
//
//  Created by Oleg Tverdokhleb on 16/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVStudent.h"
#import "Data.h"

@implementation OLTVStudent

- (instancetype)init
{
  self = [super init];
  if (self) {
    _name = firstNames[arc4random_uniform(50)];
    _age = 20 + arc4random_uniform(10);
  }
  return self;
}

- (void)setName:(NSString *)name {
  _name = name;
  
  NSLog(@"%@ setName: %@", [self class], name);
}

- (void)setAge:(NSInteger)age {
  _age = age;
  NSLog(@"%@ setAge:%ld", [self class], age);
}

- (NSString *)description {
  return [NSString stringWithFormat:@"%@ %@ %ld", [self class], _name, _age];
}

- (void)setValue:(id)value forKey:(NSString *)key {
  NSLog(@"setValue %@ forKey %@", value, key);
  [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
  NSLog(@"setValueForUndefinedKey");
}

- (id)valueForUndefinedKey:(NSString *)key {
  NSLog(@"valueForUndefinedKey");
  return nil;
}

- (void)changeName {
  [self willChangeValueForKey:@"name"];
  _name = @"FAKE_NAME";
  [self didChangeValueForKey:@"name"];
}

- (BOOL)validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKey:(NSString *)inKey error:(out NSError * _Nullable __autoreleasing *)outError {
  
  if ([inKey isEqualToString:@"name"]) {
    return [self validateName:ioValue error:outError];
  }
  
  return YES;
}

- (BOOL)validateName:(inout id  _Nullable __autoreleasing *)ioValue error:(out NSError * _Nullable __autoreleasing *)outError {
  
  NSString *newName = *ioValue;
  
  if (![newName isKindOfClass:[NSString class]]) {
    *outError = [NSError errorWithDomain:@"Not NSString" code:123 userInfo:nil];
    return NO;
  }
  
  static NSCharacterSet *set = nil;
  set = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
  if ([newName rangeOfCharacterFromSet:set].location != NSNotFound) {
    *outError = [NSError errorWithDomain:@"Has numbers" code:345 userInfo:nil];
    return NO;
  }
  
  return YES;
}

@end
