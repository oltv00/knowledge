//
//  AZAlertImageView.m
//  Project WoodCheckers
//
//  Created by Alex Alexandrov on 08.12.13.
//  Copyright (c) 2013 Alex Zbirnik. All rights reserved.
//

#import "AZAlertImageView.h"

@implementation AZAlertImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alertSpaceImage = [UIImage imageNamed:@"kosmos.png"];
        self.alertThereNotImage = [UIImage imageNamed:@"mostnot.png"];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.alertSpaceImage = [UIImage imageNamed:@"kosmos.png"];
        self.alertThereNotImage = [UIImage imageNamed:@"mostnot.png"];
    }
    return self;
}

- (void) createAlertViewImage: (UIImage *) imageAlert{
    
    self.viewImageAlert = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 220, 120)];
    self.viewImageAlert.image = imageAlert;
    self.viewImageAlert.contentMode = UIViewContentModeScaleToFill;
    [self.viewAlert addSubview:self.viewImageAlert];
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.viewAlert.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
                     }];
}

- (BOOL) noMoveToSpace: (CGPoint) pointMove andDeskSpace: (UIView *) deskView{
    
    BOOL toMoveOrNotToMove = TRUE;
    
    if(!CGRectContainsPoint(deskView.frame, pointMove)){
        
        self.viewAlert = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(deskView.bounds) - 110,
                                                                            CGRectGetMidY(deskView.bounds) - 60, 220, 120)];
        self.viewAlert.backgroundColor = [UIColor clearColor];
        [deskView addSubview:self.viewAlert];
        
        [self createAlertViewImage:self.alertSpaceImage];
        
        
        
        toMoveOrNotToMove = FALSE;
    }
    
    return toMoveOrNotToMove;
}

- (void) noThereMostNot:(UIView *) deskView{
        
        self.viewAlert = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(deskView.bounds) - 110,
                                                                  CGRectGetMidY(deskView.bounds) - 60, 220, 120)];
        self.viewAlert.backgroundColor = [UIColor clearColor];
        [deskView addSubview:self.viewAlert];
    
        [self createAlertViewImage:self.alertThereNotImage];
 
}

- (BOOL) clickToViewAlert{
    
    self.viewImageAlert.image = nil;
    [self.viewImageAlert removeFromSuperview];
    [self.viewAlert removeFromSuperview];
 
    return TRUE;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
