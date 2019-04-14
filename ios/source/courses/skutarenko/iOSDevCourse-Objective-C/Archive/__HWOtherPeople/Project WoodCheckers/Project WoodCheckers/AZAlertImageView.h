//
//  AZAlertImageView.h
//  Project WoodCheckers
//
//  Created by Alex Alexandrov on 08.12.13.
//  Copyright (c) 2013 Alex Zbirnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AZAlertImageView : UIImageView

@property (strong, nonatomic) UIImage *alertSpaceImage;
@property (strong, nonatomic) UIImage *alertThereNotImage;
@property (strong, nonatomic) UIView *viewAlert;
@property (strong, nonatomic) UIImageView *viewImageAlert;

- (BOOL) noMoveToSpace: (CGPoint) pointMove andDeskSpace: (UIView *) deskView;
- (void) noThereMostNot:(UIView *) deskView;
//+ (BOOL) noMoveToSpace: (CGPoint) pointMove andDeskSpace: (UIView *) deskView andviewAlert: (UIView *) viewAlert;
- (BOOL) clickToViewAlert;

@end
