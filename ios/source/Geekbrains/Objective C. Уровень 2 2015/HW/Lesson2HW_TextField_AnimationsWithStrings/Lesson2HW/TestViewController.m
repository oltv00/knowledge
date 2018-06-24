//
//  TestViewController.m
//  Lesson2HW
//
//  Created by Oleg Tverdokhleb on 14.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "TestViewController.h"
#import <HRColorPickerView.h>

@interface TestViewController ()
@property (strong, nonatomic) HRColorPickerView *colorPickerView;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    HRColorPickerView *colorPickerView = [[HRColorPickerView alloc] init];
    colorPickerView.color = [UIColor redColor];
    [colorPickerView addTarget:self
                        action:@selector(action:)
              forControlEvents:UIControlEventValueChanged];
    self.colorPickerView = colorPickerView;
    [self.view addSubview:colorPickerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)action:(HRColorPickerView *) colorPickerView {
    NSLog(@"action");
}
- (IBAction)actionButton:(id)sender {
    [self action:self.colorPickerView];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
