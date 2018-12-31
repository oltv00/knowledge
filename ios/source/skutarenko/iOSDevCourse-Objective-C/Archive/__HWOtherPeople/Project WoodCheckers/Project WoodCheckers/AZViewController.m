//
//  AZViewController.m
//  Project WoodCheckers
//
//  Created by Alex Alexandrov on 07.12.13.
//  Copyright (c) 2013 Alex Zbirnik. All rights reserved.
//

#import "AZViewController.h"
#import "AZBlackCellView.h"
#import "AZCheckers.h"
#import "AZAlertImageView.h"

@interface AZViewController ()

@property (weak, nonatomic) UIView *noDragginViewDesk;
@property (weak, nonatomic) UIView *dragginView;
@property (weak, nonatomic) UIView *viewAlert;
@property (strong, nonatomic) AZAlertImageView *globalAlertView;
@property (strong, nonatomic) AZBlackCellView *globalBlackCellView;
@property (assign, nonatomic) CGPoint touchOffset;
@property (assign, nonatomic) CGPoint pointBegin;
@property (assign, nonatomic) BOOL enableMove;


@end

@implementation AZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
/**************************** create chessDesk ****************************/
    
    [self createDesk];
    CGRect blackRect = CGRectMake(0, 0, 40, 40);
    self.globalBlackCellView = [[AZBlackCellView alloc] init];
    [self.globalBlackCellView createBlackCell:blackRect andDragView:self.noDragginViewDesk];
    [AZCheckers rankingCheckers:blackRect andDragView:self.noDragginViewDesk];
    self.enableMove = TRUE;
    self.globalAlertView = [[AZAlertImageView alloc] init];
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - create desk

- (void) createDesk{
    
    UIView * viewDesk = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMidY(self.view.frame) - CGRectGetWidth(self.view.frame) / 2,                           CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame))];
    
    viewDesk.backgroundColor = [UIColor clearColor];
    viewDesk.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                                    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    [self.view addSubview:viewDesk];
    self.noDragginViewDesk = viewDesk;

    UIImageView *imageViewDesk = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    imageViewDesk.image = [UIImage imageNamed:@"chessDesk.png"];
    [viewDesk addSubview:imageViewDesk];
}

#pragma mark - touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *anyTouch = [touches anyObject];
    CGPoint pointTouchView = [anyTouch locationInView:self.noDragginViewDesk];
    UIView *anyTouchView = [self.noDragginViewDesk hitTest:pointTouchView withEvent:event];
    self.pointBegin = pointTouchView;
    if(![anyTouchView isEqual:self.view] && ![anyTouchView isEqual:self.noDragginViewDesk] &&
       [self.globalBlackCellView noTouchBlackCell:anyTouchView]){
        
        if([anyTouchView isEqual:self.globalAlertView.viewAlert]){
            self.enableMove = [self.globalAlertView clickToViewAlert];
        }
   
        self.dragginView = anyTouchView;
        
        if(self.enableMove){
            
            [UIView animateWithDuration:0.3f
                             animations:^{
                                 self.dragginView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
                             }];
        }
        
        CGPoint touchPoint = [anyTouch locationInView:self.dragginView];
        [self.noDragginViewDesk bringSubviewToFront:self.dragginView];
        
        self.touchOffset = CGPointMake(CGRectGetMidX(self.dragginView.bounds) - touchPoint.x,
                                       CGRectGetMidY(self.dragginView.bounds) - touchPoint.y);
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if(self.dragginView && self.enableMove){
        UITouch *anyTouch = [touches anyObject];
        CGPoint pointTouchView = [anyTouch locationInView:self.noDragginViewDesk];
        CGPoint pointMainView = [anyTouch locationInView:self.view];
        self.enableMove = [self.globalAlertView noMoveToSpace:pointMainView
                                                 andDeskSpace:self.noDragginViewDesk];
        
        if(!self.enableMove){
            pointTouchView = self.pointBegin;
        }
        CGPoint correctionPoint = CGPointMake(pointTouchView.x + self.touchOffset.x,
                                              pointTouchView.y + self.touchOffset.y);
       
        self.dragginView.center = correctionPoint;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    BOOL moveOrNot;
    
    moveOrNot = [self.globalBlackCellView blackCellFreeOrNot: self.pointBegin
                                                andPointDrop: CGPointMake(CGRectGetMidX(self.dragginView.frame),
                                                                          CGRectGetMidY(self.dragginView.frame))];
    
    if(moveOrNot && self.enableMove){
        CGPoint correctionPoint = CGPointMake(self.pointBegin.x + self.touchOffset.x,
                                              self.pointBegin.y + self.touchOffset.y);
        
        self.dragginView.center = correctionPoint;
        [self.globalAlertView noThereMostNot:self.noDragginViewDesk];
        self.enableMove = FALSE;
    }
    else{
        
        CGPoint correctionPoint = [self.globalBlackCellView getBlackCellPoint:
                                   CGPointMake(CGRectGetMidX(self.dragginView.frame),
                                               CGRectGetMidY(self.dragginView.frame))];
        
        correctionPoint = CGPointMake(correctionPoint.x + 20, correctionPoint.y + 20);
        self.dragginView.center = correctionPoint;
    }
   
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.dragginView.transform = CGAffineTransformIdentity;
                     }];
    
       self.dragginView = nil;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
    self.dragginView = nil;
}

#pragma mark - orientation

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    
    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
    
}

- (NSUInteger) supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

@end
