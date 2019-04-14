//
//  OLTVPhotoAlbum.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 06/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVPhotoAlbum.h"

@implementation OLTVPhotoAlbum

- (instancetype)initAlbumWithAllPhotos:(NSMutableArray *)photos
                               ownerID:(NSString *)ownerID
                                  size:(NSString *)size
{
  self = [super init];
  if (self) {
    
    _ownerID = ownerID;
    _size = size;
    _title = @"All Photos";
    _photos = photos;
    _state = OLTVPhotoAlbumStateDownloaded;
    
  }
  return self;
}

- (instancetype)initWithResponse:(NSDictionary *)response {
  self = [super init];
  if (self) {
    
    _ownerID = response[@"owner_id"];
    _albumID = response[@"id"];
    _descrip = response[@"description"];
    _size = [response[@"size"] stringValue];
    _title = response[@"title"];
    _photos = [NSMutableArray array];
    _state = OLTVPhotoAlbumStateNotDownloaded;
    
  }
  return self;
}

@end
