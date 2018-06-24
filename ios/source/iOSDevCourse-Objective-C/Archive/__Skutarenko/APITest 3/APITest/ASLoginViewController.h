//
//  ASLoginViewController.h
//  APITest
//
//  Created by Oleksii Skutarenko on 26.02.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASAccessToken;

typedef void(^ASLoginCompletionBlock)(ASAccessToken* token);

@interface ASLoginViewController : UIViewController


- (id) initWithCompletionBlock:(ASLoginCompletionBlock) completionBlock;

@end
