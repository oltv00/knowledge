//
//  OTMain.m
//  7_ProtocolsHW
//
//  Created by Oleg Tverdokhleb on 01.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTMain.h"

#import "OTJumper.h"
#import "OTSwimmer.h"
#import "OTRunner.h"

@interface OTMain ()

@property (strong, nonatomic) NSMutableArray *array;

@end

@implementation OTMain

#pragma mark - LifeCycles

- (void)main {
    [self setup];
}

- (void)setup {
    [self initialize];
    [self cycles];
}

- (void)initialize {
    NSMutableArray *array = [NSMutableArray array];
    
    for (int index = 0; index < 100; index++) {
        OTJumper *jumper = [[OTJumper alloc] initWithName:@"Jumper" Index:index];
        OTSwimmer *swimmer = [[OTSwimmer alloc] initWithName:@"Swimmer" Index:index];
        OTRunner *runner = [[OTRunner alloc] initWithName:@"Runner" Index:index];
        
        [array addObject:jumper];
        [array addObject:swimmer];
        [array addObject:runner];
        
        
    }
    self.array = array;
}

- (void)cycles {
    for (id obj in self.array) {
        [self objectCheck:obj];
        NSLog(@"-------------------------------");
    }
}

#pragma mark - Help methods

- (void)objectCheck:(id)obj {
    if ([obj isKindOfClass:[OTJumper class]]) {
        OTJumper *jumper = (OTJumper *)obj;
        [jumper about];
        [jumper jump];
        if ([jumper respondsToSelector:@selector(run)]) {
            [jumper run];
        }
        if ([jumper respondsToSelector:@selector(swim)]) {
            [jumper swim];
        }
    } else if ([obj isKindOfClass:[OTRunner class]]) {
        OTRunner *runner = (OTRunner *)obj;
        [runner about];
        [runner run];
        if ([runner respondsToSelector:@selector(swim)]) {
            [runner swim];
        }
        if ([runner respondsToSelector:@selector(jump)]) {
            [runner jump];
        }
    } else if ([obj isKindOfClass:[OTSwimmer class]]) {
        OTSwimmer *swimmer = (OTSwimmer *)obj;
        [swimmer about];
        [swimmer swim];
        if ([swimmer respondsToSelector:@selector(run)]) {
            [swimmer run];
        }
        if ([swimmer respondsToSelector:@selector(jump)]) {
            [swimmer jump];
        }
    }
}




















@end
