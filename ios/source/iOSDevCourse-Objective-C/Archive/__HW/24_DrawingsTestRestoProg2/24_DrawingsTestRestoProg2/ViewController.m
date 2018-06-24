//
//  ViewController.m
//  24_DrawingsTestRestoProg2
//
//  Created by Oleg Tverdokhleb on 14.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *PPTYimageView;
@property (strong, nonatomic) UIColor *PPTYdrawColor;
@property (assign, nonatomic) CGPoint PPTYpreviousDrawingPoint;

@end

@implementation ViewController

/*
 1. Добавить еще кнопки с цветами.
 2. Добавить 2 слайдера на изменение color.alpha и радиус.
 3. Добавить второй слой UIImageView для color.alpha
 */

#pragma mark - General methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setup];
}

#pragma mark - Setup methods

- (void) setup {
    self.PPTYdrawColor = [[UIColor blackColor] colorWithAlphaComponent:1.f];
    [self setupColorButtons];
}

- (void) setupColorButtons {
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            view.layer.cornerRadius = CGRectGetHeight(view.frame) / 2;
        }
    }
}

#pragma mark - Action methods

- (IBAction)actionColorSelectedButton:(UIButton *)sender {
    
    CGFloat r, g, b, a;
    if ([sender.backgroundColor getRed:&r green:&g blue:&b alpha:&a]) {
        self.PPTYdrawColor = [UIColor colorWithRed:r green:g blue:b alpha:a];
        [self buttonAnimation:sender];
    }
}

- (void) buttonAnimation:(UIButton *)button {

    [UIView animateWithDuration:0.3f
                     animations:^{
                         button.alpha = 0.5f;
                         button.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
                          }];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         button.alpha = 1.f;
                         button.transform = CGAffineTransformIdentity;
                     }];
    
}

#pragma mark - Touches

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
    self.PPTYpreviousDrawingPoint = [touch locationInView:self.PPTYimageView];
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.PPTYimageView];
    UIGraphicsBeginImageContext(self.PPTYimageView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.PPTYimageView.image drawInRect:self.PPTYimageView.frame];
    CGContextMoveToPoint(context, self.PPTYpreviousDrawingPoint.x, self.PPTYpreviousDrawingPoint.y);
    CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
    CGContextSetLineWidth(context, 10.f);
    CGContextSetStrokeColorWithColor(context, [self.PPTYdrawColor colorWithAlphaComponent:1.f].CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetBlendMode(context,kCGBlendModeNormal);
    CGContextStrokePath(context);
    self.PPTYimageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.PPTYpreviousDrawingPoint = currentPoint;
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

- (void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

@end
