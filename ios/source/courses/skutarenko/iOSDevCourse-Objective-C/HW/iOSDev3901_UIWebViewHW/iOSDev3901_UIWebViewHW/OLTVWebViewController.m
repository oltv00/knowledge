//
//  OLTVWebViewController.m
//  iOSDev3901_UIWebViewHW
//
//  Created by Oleg Tverdokhleb on 15/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVWebViewController.h"

@interface OLTVWebViewController ()

@end

@implementation OLTVWebViewController

#pragma mark - Lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.webView loadRequest:self.request];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Additional

- (void)checkStatusNavigateButtons {
  self.backButton.enabled = [self.webView canGoBack];
  self.forwardButton.enabled = [self.webView canGoForward];
}

#pragma mark - Action

- (IBAction)actionRefreshButton:(UIBarButtonItem *)sender {
  [self.webView stopLoading];
  [self.webView reload];
}

- (IBAction)actionBackButton:(UIBarButtonItem *)sender {
  if ([self.webView canGoForward]) {
    [self.webView goBack];
  }
}

- (IBAction)actionForwardButton:(UIBarButtonItem *)sender {
  if ([self.webView canGoForward]) {
    [self.webView goForward];
  }
}

- (IBAction)actionDismissController:(UIBarButtonItem *)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
  [self.indicator startAnimating];
  [self checkStatusNavigateButtons];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  [self.indicator stopAnimating];
  [self checkStatusNavigateButtons];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
  NSLog(@"didFailLoadWithError %@", [error localizedDescription]);
  [self.indicator stopAnimating];
  [self checkStatusNavigateButtons];
}

@end
