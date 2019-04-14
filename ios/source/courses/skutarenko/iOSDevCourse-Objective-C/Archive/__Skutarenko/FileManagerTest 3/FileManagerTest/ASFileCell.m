//
//  ASFileCell.m
//  FileManagerTest
//
//  Created by Oleksii Skutarenko on 29.12.13.
//  Copyright (c) 2013 Alex Skutarenko. All rights reserved.
//

#import "ASFileCell.h"

@implementation ASFileCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
