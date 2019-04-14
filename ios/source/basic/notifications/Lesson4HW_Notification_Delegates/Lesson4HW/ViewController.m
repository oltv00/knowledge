//
//  ViewController.m
//  Lesson4HW
//
//  Created by Oleg Tverdokhleb on 05.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import "InfoViewController.h"

#import "MRQNotifObject.h"
#import "MRQDelegObject.h"

@interface ViewController () <MRQDelegObjectDelegate>

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) InfoViewController *infoVC;

- (IBAction)actionNotificationButton:(id)sender;
- (IBAction)actionDelegateButton:(id)sender;
- (IBAction)actionInfoButton:(id)sender;

@end

@implementation ViewController

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"viewDidLoad %@", self);
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setup {
    
    NSLog(@"setup");
    self.resultLabel.text = @"";
    [self addNotifications];
}

-(void)dealloc {
    
    NSLog(@"dealloc: %@", self);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action

- (IBAction)actionNotificationButton:(id)sender {
    
    NSLog(@"actionNotificationButton");
    MRQNotifObject *notificationObject = [[MRQNotifObject alloc] init];
    [notificationObject postNotification];
}

- (IBAction)actionDelegateButton:(id)sender {
    
    NSLog(@"actionDelegateButton");
    MRQDelegObject *delegObject = [[MRQDelegObject alloc] init];
    delegObject.delegate = self;
    [delegObject sendMessage];
}

- (IBAction)actionInfoButton:(id)sender {
    
    InfoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"InfoViewController"];
    [self presentViewController:vc
                       animated:YES
                     completion:nil];
}

#pragma mark - Notification

- (void) addNotifications {
    
    NSLog(@"addNotifications");
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(postNotification:)
                                                 name:ObjectNotificationWillPost
                                               object:nil];
}

- (void) postNotification:(NSNotification *) notification {
    
    NSLog(@"postNotification");
    
    self.resultLabel.text = [notification.userInfo objectForKey:NOTIFICATION_KEY];
    self.resultLabel.alpha = 0.f;
    
    [UIView animateWithDuration:2.f
                     animations:^{
                         self.resultLabel.alpha = 1.f;
                     }];
}

#pragma mark - MRQDelegObjectDelegate

-(void)objectWasSendMessage:(NSString *) message {
    
    NSLog(@"objectWasSendMessage in class %@", self);
    
    self.resultLabel.alpha = 0.f;
    self.resultLabel.text = message;
    
    [UIView animateWithDuration:2.f
                     animations:^{
                         self.resultLabel.alpha = 1.f;
                     }];
}

@end
