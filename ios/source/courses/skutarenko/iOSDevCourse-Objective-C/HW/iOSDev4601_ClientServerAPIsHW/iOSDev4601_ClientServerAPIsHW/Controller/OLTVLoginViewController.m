//
//  OLTVLoginViewController.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 19/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVLoginViewController.h"

//API
#import "../API/OLTVAccessToken.h"

@interface OLTVLoginViewController () <UIWebViewDelegate>
@property (copy, nonatomic) OLTVLoginCompletionBlock completion;
@property (weak, nonatomic) UIWebView *webView;
@end

@implementation OLTVLoginViewController

#pragma mark - View lifecycles

- (id)initWithCompletionBlock:(void (^)(OLTVAccessToken *))completion {
  self = [super init];
  if (self) {
    self.completion = completion;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupWebView];
  [self setupAuthRequest];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Private methods

- (void)setupWebView {
  CGRect frame = self.view.bounds;
  frame.origin = CGPointZero;
  UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
  webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  webView.delegate = self;
  [self.view addSubview:webView];
  self.webView = webView;
}

- (void)setupAuthRequest {
  NSString *urlString = @"https://oauth.vk.com/authorize?"
                          "client_id=5508060&"
                          "display=mobile&"
                          "redirect_uri=https://oauth.vk.com/blank.html&"
                          "scope=5127327&" //+1 +2 +4 +8 +16 +131072 +2048 +128 +1024 +8192 +262144 +4096 +4194304 +524288
                          "response_type=token&"
                          "v=5.52";
  
  NSURL *URL = [NSURL URLWithString:urlString];
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URL];
  [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  NSString *requestString = request.URL.absoluteString;
  
  if ([requestString rangeOfString:@"access_token"].location != NSNotFound) {
    
    NSArray *comps = [requestString componentsSeparatedByString:@"#"];
    if (comps.count >= 2) requestString = comps[1];
    
    NSMutableDictionary *tokenComps = [NSMutableDictionary dictionary];
    comps = [requestString componentsSeparatedByString:@"&"];
    if (comps.count >= 3) {
      for (NSString *comp in comps) {
        NSArray *parts = [comp componentsSeparatedByString:@"="];
        if (parts.count >= 2) {
          NSString *key = parts[0];
          NSString *value = parts[1];
          [tokenComps setObject:value forKey:key];
        }
      }
    }
    
    OLTVAccessToken *token = [[OLTVAccessToken alloc] initWithComponents:tokenComps];
    if (self.completion) self.completion(token);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    self.webView.delegate = nil;
    return NO;
  }
  return YES;
}

@end
