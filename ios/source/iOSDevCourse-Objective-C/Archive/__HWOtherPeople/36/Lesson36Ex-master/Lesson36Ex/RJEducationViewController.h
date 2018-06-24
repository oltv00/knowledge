//
//  RJEducationViewController.h
//  Lesson36Ex
//
//  Created by Hopreeeeenjust on 02.02.15.
//  Copyright (c) 2015 Hopreeeeenjust. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RJEducationViewDelegate;

@interface RJEducationViewController : UITableViewController
@property (weak, nonatomic) id <RJEducationViewDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *lastIndexPath;
@property (strong, nonatomic) NSString *education;

- (IBAction)actionDoneButtonPushed:(UIBarButtonItem *)sender;
@end

@protocol RJEducationViewDelegate <NSObject>
@required
- (void)didChoseEducation:(NSString *)education atIndexPath:(NSIndexPath *)indexPath;
@end