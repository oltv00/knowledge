//
//  MRQLoginViewController.h
//  46-47_ClientServerAPIs
//
//  Created by Oleg Tverdokhleb on 24.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRQAccessToken;

typedef void(^MRQLoginCompletionBlock)(MRQAccessToken *token);

@interface MRQLoginViewController : UIViewController

- (instancetype)initWithCompletionBlock:(MRQLoginCompletionBlock) completion;

//- (void)getUserAfterAuthorize;

@end
