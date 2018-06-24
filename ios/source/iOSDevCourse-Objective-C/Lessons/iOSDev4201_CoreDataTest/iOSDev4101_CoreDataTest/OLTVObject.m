//
//  OLTVObject.m
//  iOSDev4101_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 21.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVObject.h"

@implementation OLTVObject

// Insert code here to add functionality to your managed object subclass

- (BOOL)validateForDelete:(NSError * _Nullable __autoreleasing *)error {
  NSLog(@"%@ validateForDelete", NSStringFromClass([self class]));
  return YES;
}

@end
