//
//  ViewController.m
//  Lesson2
//
//  Created by Oleg Tverdokhleb on 30.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import "Engine.h"
#import "EngineBMW.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self startEngineProcess];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startEngineProcess {
    
    Engine *firstEngine = [[Engine alloc] init];
    [firstEngine makeEngine];
    
    EngineBMW *secondEngine = [[EngineBMW alloc] init];
    [secondEngine makeEngine];
}

- (void)typesTests {
    CGRect rect = CGRectMake(20, 20, 20, 20);
    
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:view];
    
    int intValue = 55;
    float floatValue = 3.14f;
    double doubleValue = 3.14345345f;
    BOOL boolValue = YES;
    
    NSNumber *intObject = @(intValue);
    NSNumber *floatObject = @(floatValue);
    NSNumber *doubleObject = @(doubleValue);
    NSNumber *boolObject = @(boolValue);
    
    NSArray *array = [NSArray arrayWithObjects:
                      intObject, floatObject,
                      doubleObject, boolObject , nil];
    
    NSLog(@"%@", array);
    
    int intValueAfterObject = [intObject intValue];
    float floatValueAfterObject = [floatObject floatValue];
    double doubleValueAfterObject = [doubleObject doubleValue];
    BOOL boolValueAfterObject = [boolObject boolValue];
    
    NSInteger integerValue = 5;
    NSString *stringObject = [NSString stringWithFormat:@"%ld", integerValue];
    NSLog(@"%@", stringObject);
}

@end
