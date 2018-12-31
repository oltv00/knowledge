//
//  OLTVLoginViewController.h
//  iOSDev4501_APITest
//
//  Created by Oleg Tverdokhleb on 14/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OLTVAccessToken;

typedef void(^OLTVLoginCompletionBlock)(OLTVAccessToken *token);

@interface OLTVLoginViewController : UIViewController
- (id)initWithCompletionBlock:(OLTVLoginCompletionBlock)completionBlock;
@end
