//
//  OLTVMessagesViewController.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 20/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVMessagesViewController.h"

typedef NS_ENUM(NSInteger, OLTVKeyboardStatus) {
  OLTVKeyboardStatusShow = 1,
  OLTVKeyboardStatusHide = 2
};

//Model
#import "../Model/OLTVUser.h"
#import "../Model/OLTVMessage.h"

//API
#import "../API/OLTVAPIManager.h"

//Consts
static NSInteger const requestCount = 15;
static NSString *const messageCellIdentifier = @"messageCellIdentifier";

@interface OLTVMessagesViewController ()

@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSMutableArray *messages;
@property (assign, nonatomic) BOOL loadingData;
@property (assign, nonatomic) OLTVKeyboardStatus keyboardStatus;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageTextFieldBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendMessageButtonConstraint;

- (IBAction)actionSendMessage:(UIButton *)sender;

@end

@implementation OLTVMessagesViewController

#pragma mark - View lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //Setups
  [self setupProperties];
  [self setupNotifications];
  [self setupGestures];
  
  //API
  [self getMessagesHistoryFromServer];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self setupTableViewOffset];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Setups
- (void)setupProperties {
  self.navigationItem.title = [NSString stringWithFormat:
                               @"%@ %@",
                               self.user.first_name,
                               self.user.last_name];
  self.messages = [NSMutableArray array];
  self.loadingData = NO;
  self.keyboardStatus = OLTVKeyboardStatusHide;
}

-(void)setupRefreshControl {
  if (!self.activityIndicator || self.tableView.tableFooterView) {
    UIActivityIndicatorView* indicatorFooter =
    [[UIActivityIndicatorView alloc]
     initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 44)];
    
    [indicatorFooter setColor:[UIColor blackColor]];
    [self.tableView setTableFooterView:indicatorFooter];
    self.activityIndicator = indicatorFooter;
  }
}

- (void)setupNotifications {
  
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(keyboardWillShowNotification:)
   name:UIKeyboardWillShowNotification
   object:nil];
  
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(keyboardWillHideNotification:)
   name:UIKeyboardWillHideNotification
   object:nil];
}

- (void)setupTableViewOffset {
  if (self.tableView.contentSize.height > self.tableView.frame.size.height) {
    CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
    [self.tableView setContentOffset:offset animated:YES];
  }
}

- (void)setupGestures {
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(handleTapGesture:)];
  [self.view addGestureRecognizer:tapGesture];
}

#pragma mark - Handle

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
  NSLog(@"handleTapGesture");
  [self.view endEditing:YES];
}

#pragma mark - Actions

- (void)actionRefreshTableView {
  if (!self.loadingData) {
    self.loadingData = YES;
    
    [[OLTVAPIManager sharedManager]
     getMessagesHistoryWithUserID:self.user.userID
     offset:0
     count:self.messages.count
     success:^(NSArray *messages) {
       if (messages) {
         
         //sorting
         messages = [self sortedMessagesArrayByMessageID:messages];
         
         [self.messages removeAllObjects];
         [self.messages addObjectsFromArray:messages];
         [self endLoadingData];
       }
     }
     failure:^(NSError *error) {
       NSLog(@"actionRefreshTableView error = %@", [error localizedDescription]);
       [self endLoadingData];
     }];
  }
}

- (IBAction)actionSendMessage:(UIButton *)sender {
  
  [[OLTVAPIManager sharedManager]
   postMessageToUserWithID:self.user.userID
   message:self.messageTextField.text
   completion:^(id response, NSError *error) {
     if (error) {
       NSLog(@"%@ postMessageToUserWithID error = %@", [self class], [error localizedDescription]);
     } else if (response) {
       self.messageTextField.text = @"";
       [self actionRefreshTableView];
     }
   }];
}

#pragma mark - API

- (void)getMessagesHistoryFromServer {
  if (!self.loadingData) {
    self.loadingData = YES;
    
    [[OLTVAPIManager sharedManager]
     getMessagesHistoryWithUserID:self.user.userID
     offset:self.messages.count
     count:requestCount
     success:^(NSArray *messages) {
       if (messages) {
         
         //sorting
         messages = [self sortedMessagesArrayByMessageID:messages];
         
         [self.messages addObjectsFromArray:messages];
         [self endLoadingData];
       }
     }
     failure:^(NSError *error) {
       NSLog(@"getMessagesHistoryWithUserID error = %@", [error localizedDescription]);
       [self endLoadingData];
     }];
  }
}

#pragma mark - Private methods

- (NSArray *)sortedMessagesArrayByMessageID:(NSArray *)messages {
  NSSortDescriptor *sortDescriptor = [NSSortDescriptor
                                      sortDescriptorWithKey:@"messageID"
                                      ascending:YES];
  messages = [messages sortedArrayUsingDescriptors:@[sortDescriptor]];
  return messages;
}

- (void)changeViewsPositionWithNotification:(NSNotification *)notification {
  NSDictionary *userInfo = notification.userInfo;
  NSValue *value = userInfo[@"UIKeyboardFrameEndUserInfoKey"];
  CGRect newRect = [value CGRectValue];
  CGFloat offset = 8.f;
  CGFloat constraint = 0.f;
  if (self.keyboardStatus == OLTVKeyboardStatusShow) {
    constraint = CGRectGetHeight(newRect) + offset;
  } else if (self.keyboardStatus == OLTVKeyboardStatusHide) {
    constraint = offset;
  }
  [UIView animateWithDuration:0.25f
                        delay:0.f
                      options:UIViewAnimationOptionAllowAnimatedContent
                   animations:^{
                     self.messageTextFieldBottomConstraint.constant = constraint;
                     self.sendMessageButtonConstraint.constant = constraint;
                     [self.view layoutIfNeeded];
                   }
                   completion:^(BOOL finished) {
                     //NSLog(@"finished = %d", finished);
                   }];
}

- (void)endLoadingData {
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    self.loadingData = NO;
    [self.activityIndicator stopAnimating];
    self.tableView.tableFooterView = nil;
    [self.tableView reloadData];
    [self setupTableViewOffset];
  });
}

#pragma mark - Notifications

- (void)keyboardWillShowNotification:(NSNotification *)notification {
  if (self.keyboardStatus == OLTVKeyboardStatusHide) {
    self.keyboardStatus = OLTVKeyboardStatusShow;
    [self changeViewsPositionWithNotification:notification];
    [self setupTableViewOffset];
  }
}

- (void)keyboardWillHideNotification:(NSNotification *)notification {
  if (self.keyboardStatus == OLTVKeyboardStatusShow) {
    self.keyboardStatus = OLTVKeyboardStatusHide;
    [self changeViewsPositionWithNotification:notification];
    [self setupTableViewOffset];
  }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  OLTVMessage *message = self.messages[indexPath.row];
  
  UITableViewCell *messageCell = [tableView dequeueReusableCellWithIdentifier:messageCellIdentifier];
  if (!messageCell) {
    messageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messageCellIdentifier];
  }
  messageCell.textLabel.text = message.body;
  
  if (message.type == OLTVMessageTypeMine) {
    messageCell.textLabel.textAlignment = NSTextAlignmentRight;
  } else if (message.type == OLTVMessageTypeYour) {
    messageCell.textLabel.textAlignment = NSTextAlignmentLeft;
  }
  
  return messageCell;
}

#pragma mark - UITableViewDelegate

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll: (UIScrollView*)scrollView {
  
  CGFloat offset = scrollView.contentOffset.y;
  CGFloat frameHeight = scrollView.frame.size.height;
  CGFloat contentHeight = scrollView.contentSize.height;
  static const CGFloat cellHeight = 44.f;
  
  if (offset + frameHeight >= contentHeight + cellHeight) {
    if (!self.loadingData) {
      [self setupRefreshControl];
      [self.activityIndicator startAnimating];
      [self actionRefreshTableView];
    }
  }
}

@end
