//
//  OLTVPostMessageViewController.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 19/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVPostMessageViewController.h"

//API
#import "../API/OLTVAPIManager.h"

@interface OLTVPostMessageViewController () <UITextViewDelegate>

@property (assign, nonatomic, getter=isFirstTap) BOOL firstTap;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;

- (IBAction)actionDone:(UIBarButtonItem *)sender;
- (IBAction)actionCancel:(UIBarButtonItem *)sender;

@end

@implementation OLTVPostMessageViewController

#pragma mark - View lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  self.firstTap = YES;
  self.messageTextView.text = @"Write text here...";
  self.messageTextView.textColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Actions {

- (IBAction)actionDone:(UIBarButtonItem *)sender {
  [[OLTVAPIManager sharedManager]
   postMessageToWallWithOwnerID:self.ownerID
   message:self.messageTextView.text];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionCancel:(UIBarButtonItem *)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
  if (self.firstTap) {
    self.firstTap = NO;
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
  }
}

@end
