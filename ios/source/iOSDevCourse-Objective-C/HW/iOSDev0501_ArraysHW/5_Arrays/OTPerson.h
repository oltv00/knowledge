//
//  OTPerson.h
//  5_Arrays
//
//  Created by Oleg Tverdokhleb on 29.03.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Gender) {
    GenderMale,
    GenderFemale
};

@interface OTPerson : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat weight;
@property (assign, nonatomic) Gender gender;
@property (assign, nonatomic) NSInteger index;

- (instancetype)initWithName:(NSString *) name Index:(NSInteger)index;
- (void)move;
- (void)genderCall;

@end
