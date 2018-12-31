//
//  ASPostCell.h
//  APITest
//
//  Created by Oleksii Skutarenko on 14.03.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASPostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* postTextLabel;

+ (CGFloat) heightForText:(NSString*) text;

@end
