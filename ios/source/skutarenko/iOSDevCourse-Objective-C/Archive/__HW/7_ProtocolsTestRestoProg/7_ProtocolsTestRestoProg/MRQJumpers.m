//
//  MRQJumpers.m
//  7_ProtocolsTestRestoProg
//
//  Created by Oleg Tverdokhleb on 19.10.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQJumpers.h"

@implementation MRQJumpers

- (void) objectInfo {
    NSLog(@"\nName: %@"
          @"\nGender: %u"
          @"\nVelocity: %.2f"
          @"\nOccupation: %d"
          @"\nMax jump height: %.2f",
          self.name, self.gender,
          self.velocity, self.occupation);
}

- (void) jump {
    
}

- (void) workout {
    
}

- (void) run {
    NSLog(@"I am not a runner, I am jumper!");
}

@end
