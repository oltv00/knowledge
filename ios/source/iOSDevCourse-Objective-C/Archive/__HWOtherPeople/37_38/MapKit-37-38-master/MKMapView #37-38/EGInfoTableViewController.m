//
//  EGInfoTableViewController.m
//  MKMapView #37-38
//
//  Created by Евгений Глухов on 27.08.15.
//  Copyright (c) 2015 EGApps. All rights reserved.
//

#import "EGInfoTableViewController.h"

@interface EGInfoTableViewController ()

@end

@implementation EGInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Выставляем поповеру свойства, полученные из дочернего контроллера
    
    if (self.userName) {
        
        NSLog(@"GOT THE NAME");
        
        [[self.userData objectAtIndex:0] setText:self.userName];
        
    }
    
    if (self.userSurname) {
        
        NSLog(@"GOT THE SURNAME");
        
        [[self.userData objectAtIndex:1] setText:self.userSurname];
        
    }
    
    if (self.userDateOfBirth) {
        
        NSLog(@"GOT THE BIRTHDAY");
        
        [[self.userData objectAtIndex:2] setText:self.userDateOfBirth];
        
    }
    
    if (self.userGender) {
        
        NSLog(@"GOT THE GENDER");
        
        [[self.userData objectAtIndex:3] setText:self.userGender];
        
    }
    
    if (self.userAddress) {
        
        NSLog(@"GOT THE ADDRESS");
        
        [[self.userData objectAtIndex:4] setText:self.userAddress];
        
        NSLog(@"userAddress - %@", self.userAddress);
        
    }
    
    if (self.userAvatar) {
        
        NSLog(@"GOT THE AVATAR");
        
        self.userImage.image = self.userAvatar;
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    
    NSLog(@"EGInfoTableViewController has been deallocated");
    
}

#pragma mark - UITableViewDataSource



- (IBAction)BackButtonAction:(UIButton *)sender {
    
    // Нажимаем - Back и контроллер уничтожается
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
