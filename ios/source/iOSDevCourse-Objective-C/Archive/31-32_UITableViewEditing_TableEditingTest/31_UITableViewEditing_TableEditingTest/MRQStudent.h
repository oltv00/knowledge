//
//  MRQStudent.h
//  31_UITableViewEditing_TableEditingTest
//
//  Created by Oleg Tverdokhleb on 29.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MRQStudent : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) CGFloat average;

+ (MRQStudent *) generateRandomStudent;

@end
