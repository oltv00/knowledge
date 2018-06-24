//
//  ViewController.m
//  iOSDev4101_CoreDataTest
//
//  Created by Oleg Tverdokhleb on 20.05.16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (strong, nonatomic) AppDelegate *appDelegate;

- (IBAction)actionAddRandomStudent:(UIButton *)sender;
- (IBAction)actionAddRandomCar:(UIButton *)sender;
- (IBAction)actionAddStudentsInAmount:(UIButton *)sender;
- (IBAction)actionAddRandomStudentWithRandomCar:(UIButton *)sender;
- (IBAction)actionDatabaseRemove:(UIButton *)sender;
- (IBAction)actionDatabaseSave:(UIButton *)sender;
- (IBAction)actionPrintAllObjects:(UIButton *)sender;
- (IBAction)actionDeleteAllObjects:(UIButton *)sender;
- (IBAction)actionDeleteRandomStudent:(UIButton *)sender;
- (IBAction)actionDeleteRandomCar:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
  self.appDelegate = appDelegate;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionAddRandomStudent:(UIButton *)sender {
  [self.appDelegate addRandomStudent];
}

- (IBAction)actionAddRandomCar:(UIButton *)sender {
  [self.appDelegate addRandomCar];
}

- (IBAction)actionAddStudentsInAmount:(UIButton *)sender {
  
  //[self.appDelegate addStudentsInAmount:<#(NSInteger)#>]
}

- (IBAction)actionAddRandomStudentWithRandomCar:(UIButton *)sender {
  [self.appDelegate addRandomStudentWithRandomCar];
}

- (IBAction)actionDatabaseRemove:(UIButton *)sender {
  [self.appDelegate databaseRemove];
}

- (IBAction)actionDatabaseSave:(UIButton *)sender {
  [self.appDelegate databaseSave];
}

- (IBAction)actionPrintAllObjects:(UIButton *)sender {
  [self.appDelegate printAllObjects];
}

- (IBAction)actionDeleteAllObjects:(UIButton *)sender {
  [self.appDelegate deleteAllObjects];
}

- (IBAction)actionDeleteRandomStudent:(UIButton *)sender {
  [self.appDelegate deleteRandomStudent];
}

- (IBAction)actionDeleteRandomCar:(UIButton *)sender {
  [self.appDelegate deleteRandomCar];
}

@end
