//
//  OLTVWebViewController.h
//  iOSDev3901_UIWebViewHW
//
//  Created by Oleg Tverdokhleb on 15/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OLTVWebViewController : UIViewController

@property (strong, nonatomic) NSURLRequest *request;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;

- (IBAction)actionRefreshButton:(UIBarButtonItem *)sender;
- (IBAction)actionBackButton:(UIBarButtonItem *)sender;
- (IBAction)actionForwardButton:(UIBarButtonItem *)sender;
- (IBAction)actionDismissController:(UIBarButtonItem *)sender;

@end
