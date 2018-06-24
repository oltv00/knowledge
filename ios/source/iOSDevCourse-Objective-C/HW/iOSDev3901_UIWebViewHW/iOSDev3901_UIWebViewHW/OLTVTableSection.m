//
//  OLTV_TableSection.m
//  iOSDev3901_UIWebViewHW
//
//  Created by Oleg Tverdokhleb on 15/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVTableSection.h"
#import "OLTVURL.h"
#import "OLTVData.h"

@implementation OLTVTableSection

- (OLTVTableSection *)initWithSectionName:(NSString *)sectionName
                               contentType:(OLTVTableSectionContentType)contentType {
  self = [super init];
  if (self) {
    _sectionName = sectionName;
    _content = [NSMutableArray array];
    _content = [self addContentWithType:contentType];
  }
  return self;
}

- (NSMutableArray *)addContentWithType:(OLTVTableSectionContentType)contentType {
  NSMutableArray *content = [NSMutableArray array];
  switch (contentType) {
    case OLTVTableSectionContentTypePDF: {
      content = [self addPDFContent];
      return content;
    }
    case OLTVTableSectionContentTypeWeb: {
      content = [self addWebContent];
      return content;
    }
  }
}

- (NSMutableArray *)addPDFContent {
  NSMutableArray *content = [NSMutableArray array];
  for (int i = 0; i < pdf_urlsCount; i++) {
    NSString *filePath = pdf_urls[i];
    NSURL *URL = [NSURL URLWithString:filePath];
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:URL];
    OLTVURL *oltv_url = [[OLTVURL alloc] initWithURLRequest:URLRequest];
    [content addObject:oltv_url];
  }
  return content;
}

- (NSMutableArray *)addWebContent {
  NSMutableArray *content = [NSMutableArray array];
  for (int i = 0; i < web_urlsCount; i++) {
    NSString *webUrl = web_urls[i];
    NSURL *URL = [NSURL URLWithString:webUrl];
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:URL];
    OLTVURL *oltv_url = [[OLTVURL alloc] initWithURLRequest:URLRequest];
    [content addObject:oltv_url];
  }
  return content;
}

@end
