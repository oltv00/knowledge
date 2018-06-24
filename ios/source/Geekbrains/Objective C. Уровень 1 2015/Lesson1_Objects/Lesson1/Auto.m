//
//  Auto.m
//  Lesson1
//
//  Created by Oleg Tverdokhleb on 29.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "Auto.h"



@implementation Auto

- (void)driveAuto:(AutoDirection) direction {
    NSLog(@"driveAuto");
    
    [self openTheDoor];
    [self rotateSteringWheel:direction];
    [self carMoving];
}

- (void)openTheDoor {
    NSLog(@"openTheDoor");
}

- (void) rotateSteringWheel:(AutoDirection) direction {
    
    NSString *stringDirection = nil;
    
    if (direction == AutoDirectionLeft) {
        
        stringDirection = @"Move Left";
        self.direction = stringDirection;
        NSLog(@"%@", stringDirection);
        
    } else {
        
        stringDirection = @"Move right";
        self.direction = stringDirection;
        NSLog(@"%@", stringDirection);
    }
}

- (void)carMoving {
    NSLog(@"Wow, car moving");
}
@end
