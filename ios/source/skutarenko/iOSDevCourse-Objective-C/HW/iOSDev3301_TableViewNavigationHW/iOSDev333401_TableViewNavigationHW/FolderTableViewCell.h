//
//  FolderTableViewCell.h
//  iOSDev333401_TableViewNavigationHW
//
//  Created by Oleg Tverdokhleb on 30.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FolderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

@end
