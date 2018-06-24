//
//  MRQEducationViewController.h
//  36_UIPopoverControllerRestoProg
//
//  Created by Oleg Tverdokhleb on 21.12.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MRQEducationDelegate;

@interface MRQEducationViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *educationPickerView;
@property (weak, nonatomic) id <MRQEducationDelegate> delegate;

- (IBAction)doneButtonPressed:(UIButton *)sender;

@end


@protocol MRQEducationDelegate <NSObject>

- (void) didFinishEducation:(NSString *) education;

@end