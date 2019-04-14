//
//  OLTVMessagesViewController.h
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 20/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OLTVUser;

@interface OLTVMessagesViewController : UIViewController

@property (strong, nonatomic) OLTVUser *user;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
