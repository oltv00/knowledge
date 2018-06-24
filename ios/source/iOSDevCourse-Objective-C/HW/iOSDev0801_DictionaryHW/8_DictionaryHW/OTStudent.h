//
//  OTStudent.h
//  8_DictionaryHW
//
//  Created by Oleg Tverdokhleb on 01.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTStudent : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastName;

- (void)greeting;

@end
