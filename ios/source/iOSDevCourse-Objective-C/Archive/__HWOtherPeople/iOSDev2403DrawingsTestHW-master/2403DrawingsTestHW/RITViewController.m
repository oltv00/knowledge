//
//  RITViewController.m
//  2403DrawingsTestHW
//
//  Created by Aleksandr Pronin on 13.04.14.
//  Copyright (c) 2014 Aleksandr Pronin. All rights reserved.
//

#import "RITViewController.h"

@interface RITViewController ()

@property (strong, nonatomic) UIColor *color;
@property (assign, nonatomic) CGFloat brushSize;
@property (assign, nonatomic) CGFloat brushOpacity;
@property (assign, nonatomic) CGPoint lastPoint;
@property (assign, nonatomic) BOOL mouseSwiped;

@end

@implementation RITViewController

#pragma mark - RITViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // rotate slider
    /*
    CGPoint center;
    center.x = self.brushSizeSlider.frame.origin.x;
    self.brushSizeSlider.transform = CGAffineTransformMakeRotation(M_PI_2);
    center.y = self.brushSizeValueLabel.frame.origin.y + (self.brushPreview.frame.origin.y + self.brushPreview.frame.size.height - self.brushSizeValueLabel.frame.origin.y)/2;
    self.brushSizeSlider.center = center;
    */
    
    self.clearCanvasButton.adjustsImageWhenHighlighted = NO;
    self.eraserButton.adjustsImageWhenHighlighted = NO;
    
    [self propertyInitialization];
    [self drowBrushPreview:self.brushPreview withColor:self.color Size:self.brushSize andOpacity:self.brushOpacity];
    [self setSlidersWithColor:self.color];
    [self setSlidersLabelWithColor:self.color];
    
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            view.layer.cornerRadius = CGRectGetHeight(view.frame) / 2;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper methods

- (void) propertyInitialization {
    
    self.color = [UIColor blackColor];
    self.brushSize = 30.f;
    self.brushOpacity = 0.8f;
    
}

- (void) drowBrushPreview:(UIImageView*) preview withColor:(UIColor*) color Size:(CGFloat) size andOpacity:(CGFloat) alpha {
    
    // set label value
    self.brushSizeValueLabel.text = [NSString stringWithFormat:@"%.2f", size];
    self.brushOpacityValueLabel.text = [NSString stringWithFormat:@"%.2f", alpha];
    
    // initialization
    UIGraphicsBeginImageContext(preview.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // drow the black border
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextAddRect(context, preview.bounds);
    CGContextStrokePath(context);
    
    CGPoint center = [self.view convertPoint:preview.center toView:preview];
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, size);
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddLineToPoint(context, center.x, center.y);
    
    CGContextStrokePath(context);
    preview.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (void) setSlidersWithColor:(UIColor*)color {
    
    CGFloat r, g, b, a;
    
    if ([color getRed:&r green:&g blue:&b alpha:&a]) {
        
        self.redSlider.value = r * 255;
        self.greenSlider.value = g * 255;
        self.blueSlider.value = b * 255;
    }
}

- (void) setSlidersLabelWithColor:(UIColor*)color {
    
    CGFloat r, g, b, a;
    
    if ([color getRed:&r green:&g blue:&b alpha:&a]) {
        
        self.redValueLabel.text = [NSString stringWithFormat:@"%.f", r * 255];
        self.greenValueLabel.text = [NSString stringWithFormat:@"%.f", g * 255];
        self.blueValueLabel.text = [NSString stringWithFormat:@"%.f", b * 255];
    }
}

#pragma mark - Tuoches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    self.lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.canvas.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.tempCanvas.image drawInRect:CGRectMake(0, 0, self.tempCanvas.frame.size.width, self.tempCanvas.frame.size.height)];
    
    CGContextMoveToPoint(context, self.lastPoint.x, self.lastPoint.y);
    CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.brushSize);
    CGContextSetStrokeColorWithColor(context, [[self.color colorWithAlphaComponent:1.0] CGColor]);
    CGContextSetBlendMode(context,kCGBlendModeNormal);
    CGContextStrokePath(context);
    
    self.tempCanvas.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempCanvas setAlpha:self.brushOpacity];
    UIGraphicsEndImageContext();
    
    self.lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!self.mouseSwiped) {
        
        UIGraphicsBeginImageContext(self.canvas.frame.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        [self.canvas.image drawInRect:CGRectMake(0, 0, self.canvas.frame.size.width, self.canvas.frame.size.height)];
        
        CGContextMoveToPoint(context, self.lastPoint.x, self.lastPoint.y);
        CGContextAddLineToPoint(context, self.lastPoint.x, self.lastPoint.y);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, self.brushSize);
        CGContextSetStrokeColorWithColor(context, [self.color CGColor]);
        CGContextSetBlendMode(context,kCGBlendModeNormal);
        CGContextStrokePath(context);
        self.canvas.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.canvas.frame.size);
    
    [self.canvas.image
        drawInRect:CGRectMake(0, 0, CGRectGetWidth(self.canvas.frame), CGRectGetHeight(self.canvas.frame))
        blendMode:kCGBlendModeNormal alpha:1.0];
    
    [self.tempCanvas.image
        drawInRect:CGRectMake(0, 0, CGRectGetWidth(self.canvas.frame), CGRectGetHeight(self.canvas.frame))
        blendMode:kCGBlendModeNormal alpha:self.brushOpacity];
    
    self.canvas.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempCanvas.image = nil;
    UIGraphicsEndImageContext();
}

#pragma mark - Actions

- (IBAction)actionColorSelectedButton:(UIButton *)sender {
    
    CGFloat r, g, b, a;
    
    if ([sender.backgroundColor getRed:&r green:&g blue:&b alpha:&a]) {
        
        self.color = [UIColor colorWithRed:r green:g blue:b alpha:self.brushOpacity];
        [self drowBrushPreview:self.brushPreview withColor:self.color Size:self.brushSize andOpacity:self.brushOpacity];
        
        [self setSlidersWithColor:self.color];
        [self setSlidersLabelWithColor:self.color];
        
        [UIView animateWithDuration:0.3f animations:^{
            sender.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
            sender.alpha = 0.6f;
        }];
        [UIView animateWithDuration:0.3f animations:^{
            sender.transform = CGAffineTransformIdentity;
            sender.alpha = 1.f;
        }];
    }
}

- (IBAction)brushOpacityValueChanged:(UISlider *)sender {
    
    self.brushOpacity = self.brushOpacitySlider.value;
    
    CGFloat r, g, b, a;
    if ([self.color getRed:&r green:&g blue:&b alpha:&a]) {
        
        self.color = [UIColor colorWithRed:r green:g blue:b alpha:self.brushOpacity];
        [self drowBrushPreview:self.brushPreview withColor:self.color Size:self.brushSize andOpacity:self.brushOpacity];
    }
}

- (IBAction)clearCanvasButtonIsTouched:(UIButton *)sender {
    
    self.canvas.image = nil;
    
    // debug
    /*
    UIImage *img = [UIImage imageNamed:@"Eraser02.png"];
    UIGraphicsBeginImageContext(self.canvas.frame.size);
    [img drawInRect:CGRectMake(0, 0, self.canvas.frame.size.width, self.canvas.frame.size.height)];
    self.canvas.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    */
    // debug
    
    [UIView animateWithDuration:0.3f animations:^{
        sender.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
    }];
    [UIView animateWithDuration:0.3f animations:^{
        sender.transform = CGAffineTransformIdentity;
    }];
    
}

- (IBAction)rgbValueChanged:(UISlider *)sender {
    
    CGFloat r, g, b;
    r = self.redSlider.value / 255;
    g = self.greenSlider.value / 255;
    b = self.blueSlider.value / 255;
    
    self.color = [UIColor colorWithRed:r green:g blue:b alpha:self.brushOpacity];
    [self setSlidersLabelWithColor:self.color];
    [self drowBrushPreview:self.brushPreview withColor:self.color Size:self.brushSize andOpacity:self.brushOpacity];
    
}

- (IBAction)brushSizeValueChanged:(UISlider *)sender {
    
    self.brushSize = self.brushSizeSlider.value;
    [self drowBrushPreview:self.brushPreview withColor:self.color Size:self.brushSize andOpacity:self.brushOpacity];
}

@end
