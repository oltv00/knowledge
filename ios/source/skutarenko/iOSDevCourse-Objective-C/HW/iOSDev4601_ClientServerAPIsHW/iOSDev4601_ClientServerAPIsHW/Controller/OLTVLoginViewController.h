//
//  OLTVLoginViewController.h
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 19/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <UIKit/UIKit.h>

//API
@class OLTVAccessToken;

typedef void(^OLTVLoginCompletionBlock)(OLTVAccessToken *token);

@interface OLTVLoginViewController : UIViewController

- (id)initWithCompletionBlock:(void(^)(OLTVAccessToken *token))completion;

@end
