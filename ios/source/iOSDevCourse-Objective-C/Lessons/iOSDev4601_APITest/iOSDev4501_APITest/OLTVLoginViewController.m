//
//  OLTVLoginViewController.m
//  iOSDev4501_APITest
//
//  Created by Oleg Tverdokhleb on 14/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVLoginViewController.h"

@interface OLTVLoginViewController ()
@property (copy, nonatomic) OLTVLoginCompletionBlock completionBlock;
@end

@implementation OLTVLoginViewController

- (id)initWithCompletionBlock:(OLTVLoginCompletionBlock)completionBlock {
  self = [super init];
  if (self) {
    self.completionBlock = completionBlock;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  CGRect frame = self.view.bounds;
  frame.origin = CGPointZero;
  UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
  webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:webView];
  
  UIBarButtonItem *dismiss = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStyleDone target:self action:@selector(actionDismiss:)];
  self.navigationItem.rightBarButtonItem = dismiss;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)actionDismiss:(UIBarButtonItem *)sender {
  
  if (self.completionBlock) {
    self.completionBlock(nil);
  }
  
  [self dismissViewControllerAnimated:YES completion:nil];
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
