//
//  LogViewController.h
//  Lesson3
//
//  Created by Oleg Tverdokhleb on 03.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@protocol LogViewDelegate;

@interface LogViewController : ViewController

@property (weak, nonatomic) id <LogViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@protocol LogViewDelegate <NSObject>
@required

- (void) didAddNewStringToLog:(NSString *) stringLog;

@end
