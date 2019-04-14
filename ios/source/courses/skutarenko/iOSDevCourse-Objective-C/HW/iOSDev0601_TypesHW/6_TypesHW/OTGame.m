//
//  OTGame.m
//  6_TypesHW
//
//  Created by Oleg Tverdokhleb on 31.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "OTGame.h"

@interface OTGame ()

@property (assign, nonatomic) CGRect mainArea;
@property (assign, nonatomic) CGRect hitArea;
@property (assign, nonatomic) CGPoint hitPoint;
@property (assign, nonatomic) NSInteger hits;
@property (assign, nonatomic) NSInteger miss;
@property (assign, nonatomic) BOOL isLose;

@end

@implementation OTGame

- (void)launchGame {
    [self initialProperties];
    [self initialMainArea];
    [self initialHitArea];
    NSLog(@"----INITIALIZE-IS-OVER----");
    [self gameCycle];
}

- (void)initialProperties {
    self.hits = 0;
    self.miss = 0;
    self.isLose = NO;
}

- (void)initialMainArea {
    CGRect mainArea = CGRectMake(0, 0, 50, 50);
    self.mainArea = mainArea;
    NSLog(@"Main area is initialize: %@", NSStringFromCGRect(mainArea));
}

- (void)initialHitArea {
    CGRect hitArea = CGRectMake(5, 5, 45, 45);
    self.hitArea = hitArea;
    NSLog(@"Hit area is initialize: %@", NSStringFromCGRect(hitArea));
}

- (void)gameCycle {
    while (self.hits < 30) {
        [self shoot];
        if (self.miss > 14) {
            self.isLose = YES;
            NSLog(@"You Lose! : (");
            break;
        }
    }
    if (self.isLose == NO) {
        NSLog(@"CONGRATZ");
        NSLog(@"You Win!");
    }
}

- (void)shoot {
    CGPoint hit;
    CGFloat x = arc4random_uniform(50);
    CGFloat y = arc4random_uniform(50);
    hit = CGPointMake(x, y);
    self.hitPoint = hit;
    NSLog(@"Shot is: %@ in hit area %@", NSStringFromCGPoint(hit), NSStringFromCGRect(self.hitArea));
    BOOL isHit = [self isHit];
    if (isHit) {
        isHit = NO;
        self.hits += 1;
        NSLog(@"HIT!");
        [self descrip];
    } else {
        self.miss += 1;
        NSLog(@"MISS! : (");
        [self descrip];
    }
}

- (void)descrip {
    NSLog(@"You have %ld hits", self.hits);
    NSLog(@"You have %ld miss", self.miss);
    NSLog(@"-------------------------------");
}

- (BOOL)isHit {
    if (CGRectContainsPoint(self.hitArea, self.hitPoint)) {
        return YES;
    }
    return NO;
}

@end
