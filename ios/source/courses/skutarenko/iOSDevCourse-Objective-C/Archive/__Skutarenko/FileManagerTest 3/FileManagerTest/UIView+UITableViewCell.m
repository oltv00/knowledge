//
//  UIView+UITableViewCell.m
//  FileManagerTest
//
//  Created by Oleksii Skutarenko on 29.12.13.
//  Copyright (c) 2013 Alex Skutarenko. All rights reserved.
//

#import "UIView+UITableViewCell.h"

@implementation UIView (UITableViewCell)


- (UITableViewCell*) superCell {
    
    if (!self.superview) {
        return nil;
    }
    
    if ([self.superview isKindOfClass:[UITableViewCell class]]) {
        return (UITableViewCell*)self.superview;
    }
    
    return [self.superview superCell];
}

@end
