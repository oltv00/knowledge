//
//  ViewController.h
//  28_TextFieldFormatTest
//
//  Created by Oleg Tverdokhleb on 21.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;


@end

