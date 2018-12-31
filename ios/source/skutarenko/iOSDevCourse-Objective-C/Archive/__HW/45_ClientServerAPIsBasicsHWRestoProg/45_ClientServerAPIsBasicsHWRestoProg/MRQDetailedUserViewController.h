//
//  MRQDetailedUserViewController.h
//  45_ClientServerAPIsBasicsHWRestoProg
//
//  Created by Oleg Tverdokhleb on 18.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRQDetailedUserViewController : UITableViewController

@property (assign, nonatomic) NSInteger userID;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
