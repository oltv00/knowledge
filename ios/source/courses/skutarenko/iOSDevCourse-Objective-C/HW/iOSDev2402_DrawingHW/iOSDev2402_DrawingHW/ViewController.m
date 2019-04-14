//
//  ViewController.m
//  iOSDev2402_DrawingHW
//
//  Created by Oleg Tverdokhleb on 19.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import "FCColorPickerViewController.h"

@interface ViewController () <FCColorPickerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *drawView;
@property (assign, nonatomic) CGPoint previousDrawingPoint;
@property (strong, nonatomic) UIColor *color;
@end

@implementation ViewController
- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

#pragma mark - View cycles
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
#pragma - Color pick
-(IBAction)chooseColor:(id)sender {
    FCColorPickerViewController *colorPicker = [FCColorPickerViewController colorPicker];
    colorPicker.color = self.color;
    colorPicker.delegate = self;
    
    [colorPicker setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:colorPicker animated:YES completion:nil];
}

#pragma mark - FCColorPickerViewControllerDelegate Methods

-(void)colorPickerViewController:(FCColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color {
    self.color = color;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)colorPickerViewControllerDidCancel:(FCColorPickerViewController *)colorPicker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Touches
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    self.previousDrawingPoint = [touch locationInView:self.drawView];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIGraphicsBeginImageContext(self.drawView.frame.size);
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.drawView];
    
    //context init
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //context settings
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(ctx, 2.f);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    
    //draw
    [self.drawView.image drawInRect:self.drawView.frame];
    CGContextMoveToPoint(ctx, self.previousDrawingPoint.x, self.previousDrawingPoint.y);
    CGContextAddLineToPoint(ctx, currentPoint.x, currentPoint.y);
    CGContextStrokePath(ctx);
    
    //end setup
    self.drawView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.previousDrawingPoint = currentPoint;
}

@end
