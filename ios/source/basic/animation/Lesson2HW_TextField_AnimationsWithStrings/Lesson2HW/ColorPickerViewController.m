//
//  ColorPickerViewController.m
//  Lesson2HW
//
//  Created by Oleg Tverdokhleb on 14.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ColorPickerViewController.h"

@interface ColorPickerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelPreviewColor;
@property (strong, nonatomic) NSArray *arrayColors;

@end

@implementation ColorPickerViewController

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setup {
    self.arrayColors = @[
                         [UIColor redColor],
                         [UIColor greenColor],
                         [UIColor blueColor]
                         ];
}





























@end
