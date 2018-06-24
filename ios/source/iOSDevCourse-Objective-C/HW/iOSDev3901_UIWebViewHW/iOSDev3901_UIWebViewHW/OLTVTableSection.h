//
//  OLTV_TableSection.h
//  iOSDev3901_UIWebViewHW
//
//  Created by Oleg Tverdokhleb on 15/05/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OLTVURL;

typedef NS_ENUM(NSInteger, OLTVTableSectionContentType) {
  OLTVTableSectionContentTypePDF,
  OLTVTableSectionContentTypeWeb
};

@interface OLTVTableSection : NSObject

@property (assign, nonatomic) NSString *sectionName;
@property (strong, nonatomic) NSMutableArray <OLTVURL*> *content;

- (OLTVTableSection *)initWithSectionName:(NSString *)sectionName
                               contentType:(OLTVTableSectionContentType)contentType;


@end
