//
//  RITViewController.h
//  2403DrawingsTestHW
//
//  Created by Aleksandr Pronin on 13.04.14.
//  Copyright (c) 2014 Aleksandr Pronin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RITViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *canvas;
@property (weak, nonatomic) IBOutlet UIImageView *tempCanvas;
@property (weak, nonatomic) IBOutlet UIImageView *brushPreview;

@property (weak, nonatomic) IBOutlet UISlider *brushSizeSlider;
@property (weak, nonatomic) IBOutlet UISlider *brushOpacitySlider;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@property (weak, nonatomic) IBOutlet UILabel *brushSizeValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *brushOpacityValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *redValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *greenValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueValueLabel;

@property (weak, nonatomic) IBOutlet UIButton *clearCanvasButton;
@property (weak, nonatomic) IBOutlet UIButton *eraserButton;

- (IBAction)brushSizeValueChanged:(UISlider *)sender;
- (IBAction)actionColorSelectedButton:(UIButton *)sender;
- (IBAction)brushOpacityValueChanged:(UISlider *)sender;
- (IBAction)clearCanvasButtonIsTouched:(UIButton *)sender;

- (IBAction)rgbValueChanged:(UISlider *)sender;

@end
