//
//  OTVObject.m
//  4_ParametersTest
//
//  Created by Oleg Tverdokhleb on 28.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTObject.h"

@interface OTObject ()
@property (strong, nonatomic) NSString *objectValidation;
@property (assign, nonatomic) NSInteger objectID;
@end

@implementation OTObject

- (instancetype)initWithObjectID:(NSInteger) objectID {
    self = [super init];
    if (self) {
        NSLog(@"OBJECT IS CREATED");
        self.objectValidation = [NSString stringWithFormat:@"CURRENT_OBJECT #%ld", objectID];
        self.objectID = objectID;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%@ is deallocated", self);
}

- (NSString *)description {
    return [NSString stringWithFormat:  @"\nVALIDATION: %@"
                                        @"\nMy ID in application %ld",
                                        self.objectValidation, self.objectID];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    OTObject *newObject = [[OTObject alloc] init];
    newObject.objectValidation = self.objectValidation;
    newObject.objectID = self.objectID;
    return newObject;
}

@end
