//
//  MRQLoginViewController.m
//  46-47_ClientServerAPIs
//
//  Created by Oleg Tverdokhleb on 24.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQServerManager.h"
#import "MRQAccessToken.h"

#import "MRQLoginViewController.h"

@interface MRQLoginViewController () <UIWebViewDelegate>

@property (copy, nonatomic) MRQLoginCompletionBlock completionBlock;
@property (weak, nonatomic) UIWebView *webView;

@end

@implementation MRQLoginViewController

- (instancetype)initWithCompletionBlock:(void (^)(MRQAccessToken *))completion
{
    self = [super init];
    if (self) {
        self.completionBlock = completion;
    }
    return self;
}

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cancelBarButtonInitial];
    [self webViewInitial];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc {
    self.webView.delegate = nil;
}

- (void)cancelBarButtonInitial {
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                             target:self
                             action:@selector(actionCancelBarButton:)];
    
    [self.navigationItem setRightBarButtonItem:item animated:YES];
}

- (void)webViewInitial {
    
    self.navigationItem.title = @"Login";
    
    CGRect rect = self.view.bounds;
    rect.origin = CGPointZero;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:rect];
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    webView.delegate = self;
    
    [self.view addSubview:webView];
    self.webView = webView;
    
    NSString *urlString =
        @"https://oauth.vk.com/authorize?"
        "client_id=5240201&"
        "display=mobile&"
        "redirect_uri=hello.there&"
        "scope=notify,friends,photos&"
        "response_type=token&"
        "v=5.44";
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark - Actions

- (void)actionCancelBarButton:(id)sender {
    
    if (self.completionBlock) {
        self.completionBlock(nil);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@", [request description]);
    
    if ([[[request URL] host] isEqualToString:@"hello.there"]) {
        
        MRQAccessToken* token = [[MRQAccessToken alloc] init];
        NSString* query = [[request URL] description];
        NSArray* array = [query componentsSeparatedByString:@"#"];
        
        if ([array count] > 1) {
            query = [array lastObject];
        }
        
        NSArray* pairs = [query componentsSeparatedByString:@"&"];
        for (NSString* pair in pairs) {
            NSArray* values = [pair componentsSeparatedByString:@"="];
            
            if ([values count] == 2) {
                NSString* key = [values firstObject];
                
                if ([key isEqualToString:@"access_token"]) {
                    token.name = [values lastObject];
                } else if ([key isEqualToString:@"expires_in"]) {
                    
                    NSTimeInterval interval = [[values lastObject] doubleValue];
                    token.expiresDate = [NSDate dateWithTimeIntervalSinceNow:interval];
                    
                } else if ([key isEqualToString:@"user_id"]) {
                    
                    token.userID = [values lastObject];
                }
            }
        }
        
        self.webView.delegate = nil;
        
        if (self.completionBlock) {
            self.completionBlock(token);
        }

        [self dismissViewControllerAnimated:YES
                                 completion:nil];
        
        return NO;
    }
    
    return YES;
}

@end
