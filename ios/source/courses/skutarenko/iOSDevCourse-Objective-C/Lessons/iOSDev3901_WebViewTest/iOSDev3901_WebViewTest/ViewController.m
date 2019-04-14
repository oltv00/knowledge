//
//  ViewController.m
//  iOSDev3901_WebViewTest
//
//  Created by Oleg Tverdokhleb on 13/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
//  [self level1];
//  [self level2];
//  [self level3];
  [self level4];
}

- (void)level4 {
  NSString *htmlString =
  @"<html>"
    "<boyd>"
      "<p style = \"font-size:200%%; text-align: center;\">HELLO WORLD!</p>"
      "<a href=\"https://vk.com/iosdevcourse\">iOS Dev Course</a>"
      "<br>"
      "<a href=\"cmd:show_alert\">TEST BUTTON</a>"
    "</boyd>"
  "</html>";
  [self.webView loadHTMLString:htmlString baseURL:nil];
}

- (void)level3 {
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"pdf"];
  NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
  NSURLRequest *urlRequest = [NSURLRequest requestWithURL:fileUrl];
  [self.webView loadRequest:urlRequest];
}

- (void)level2 {
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"pdf"];
  NSData *fileData = [NSData dataWithContentsOfFile:filePath];
  [self.webView loadData:fileData MIMEType:@"application/pdf" textEncodingName:@"UTF-8" baseURL:nil];
}

- (void)level1 {
  NSString *urlString = @"https://vk.com/iosdevcourse";
  NSURL *url = [[NSURL alloc] initWithString:urlString];
  NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
  [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Additional

- (void)navigationButtonsStatusUpdate {
  self.backButtonItem.enabled = [self.webView canGoBack];
  self.forwardButtonItem.enabled = [self.webView canGoForward];
}

#pragma mark - Action

- (IBAction)actionBack:(id)sender {
  if ([self.webView canGoBack]) {
    [self.webView goBack];
  }
}

- (IBAction)actionForward:(id)sender {
  if ([self.webView canGoForward]) {
    [self.webView goForward];
  }
}

- (IBAction)actionRefresh:(id)sender {
  [self.webView reload];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  
  NSLog(@"shouldStartLoadWithRequest %@", [request description]);
  
  NSString *urlString = [request.URL absoluteString];
  
  if ([urlString hasPrefix:@"cmd:"]) {
    NSString *command = [urlString substringFromIndex:4];
    
    if ([command isEqualToString:@"show_alert"]) {
      
      UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"This is alert" preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
      [alert addAction:action];
      [self presentViewController:alert animated:YES completion:nil];
    }
    
    return NO;
  }
  
  return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
  NSLog(@"webViewDidStartLoad");
  [self.loadIndicator startAnimating];
  [self navigationButtonsStatusUpdate];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  NSLog(@"webViewDidFinishLoad");
  [self.loadIndicator stopAnimating];
  [self navigationButtonsStatusUpdate];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
  NSLog(@"didFailLoadWithError %@", [error localizedDescription]);
  [self.loadIndicator stopAnimating];
}


@end
