//
//  OLTV_URL.h
//  iOSDev3901_UIWebViewHW
//
//  Created by Oleg Tverdokhleb on 15/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OLTVURL : NSObject

@property (strong, nonatomic) NSString *urlName;
@property (strong, nonatomic) NSURLRequest *URLRequest;

- (OLTVURL *)initWithURLRequest:(NSURLRequest *)URLRequest;

@end
