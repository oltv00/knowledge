//
//  OLTVSubscriptionsTableViewController.h
//  iOSDev4501_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 04/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OLTVSubscriptionsTableViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *userID;
@end
