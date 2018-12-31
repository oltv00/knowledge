//
//  ViewController.m
//  iOSDev3601_PopoversTest
//
//  Created by Oleg Tverdokhleb on 02.05.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import "DetailsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (void)showControllerAsModal:(UIViewController *)vc {
  [self presentViewController:vc animated:YES completion:^{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [vc dismissViewControllerAnimated:YES completion:nil];
    });
  }];
}

- (void)showController:(UIViewController *)vc inPopoverFromSender:(id)sender {
  
  vc.modalPresentationStyle = UIModalPresentationPopover;
//  vc.preferredContentSize = CGSizeMake(300, 300);
  UIPopoverPresentationController *pc = [vc popoverPresentationController];
  
  if ([sender isKindOfClass:[UIBarButtonItem class]]) {

    pc.barButtonItem = sender;
    pc.permittedArrowDirections = UIPopoverArrowDirectionUp;
    pc.sourceView = self.view;
    pc.sourceRect = CGRectZero;
    
  } else if ([sender isKindOfClass:[UIButton class]]) {

    pc.permittedArrowDirections = UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight;
    pc.sourceView = self.view;
    pc.sourceRect = [sender frame];
  }
  
  [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)actionAdd:(UIBarButtonItem *)sender {
  DetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
  
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    [self showController:vc inPopoverFromSender:sender];
  } else {
    [self showControllerAsModal:vc];
  }
}

- (IBAction)actionPressMe:(UIButton *)sender {
  DetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
  
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    [self showController:vc inPopoverFromSender:sender];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [vc dismissViewControllerAnimated:YES completion:nil];
    });
  
  } else {
    [self showControllerAsModal:vc];
  }
}

#pragma mark - Segue

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//  if ([segue.identifier isEqualToString:@"pressMe"]) {
//    UIViewController *vc = segue.destinationViewController;
//    UIPopoverPresentationController *pc = [vc popoverPresentationController];
//    
//    pc.permittedArrowDirections = UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight;
//    pc.sourceView = self.view;
//    pc.sourceRect = [sender frame];
//  }
//}

@end
