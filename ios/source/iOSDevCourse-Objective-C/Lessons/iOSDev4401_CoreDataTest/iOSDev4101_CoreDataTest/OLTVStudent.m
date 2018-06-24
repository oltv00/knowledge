//
//  OLTVStudent.m
//  iOSDev4101_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 20.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVStudent.h"

@implementation OLTVStudent

// Insert code here to add functionality to your managed object subclass

- (void)setFirstName:(NSString *)firstName {
  [self willChangeValueForKey:@"firstName"];
  [self setPrimitiveValue:firstName forKey:@"firstName"];
  [self didChangeValueForKey:@"firstName"];
  
  //NSLog(@"setFirstName %@" ,firstName);
}

- (NSString *)firstName {
  NSString *returnString = nil;
  [self willAccessValueForKey:@"firstName"];
  returnString = [self primitiveValueForKey:@"firstName"];
  [self didAccessValueForKey:@"firstName"];
  //NSLog(@"getFirstName %@", returnString);
  return returnString;
}


- (BOOL)validateLastName:(id  _Nullable __autoreleasing *)value error:(NSError * _Nullable __autoreleasing *)error {
  //*error = [NSError errorWithDomain:@"BAD LAST NAME" code:123 userInfo:nil];
  return YES;
}

@end
