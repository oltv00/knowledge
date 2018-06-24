//
//  MRQAddNewUserTableViewCell.h
//  41-44_CoreDataHWRestoProg
//
//  Created by Oleg Tverdokhleb on 13.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRQAddNewUserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *familyLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *familyTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end
