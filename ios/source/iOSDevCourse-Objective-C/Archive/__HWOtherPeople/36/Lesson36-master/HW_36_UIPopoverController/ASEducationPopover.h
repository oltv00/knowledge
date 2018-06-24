//
//  ASEducationPopover.h
//  HW_36_UIPopoverController
//
//  Created by MD on 04.07.15.
//  Copyright (c) 2015 hh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ASEducationPopoverDelegate <NSObject>

@required
- (void)dataFromEducationController:(NSString *)data;
@end



@interface ASEducationPopover : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSArray* dataForArray;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, weak) id<ASEducationPopoverDelegate> delegate;

@end
