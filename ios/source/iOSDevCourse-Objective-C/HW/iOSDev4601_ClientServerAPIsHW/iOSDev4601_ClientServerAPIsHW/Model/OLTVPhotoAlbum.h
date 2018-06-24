//
//  OLTVPhotoAlbum.h
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 06/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, OLTVPhotoAlbumState) {
  OLTVPhotoAlbumStateNotDownloaded = 0,
  OLTVPhotoAlbumStateDownloaded = 1
};

@interface OLTVPhotoAlbum : NSObject

@property (strong, nonatomic) NSString *ownerID;
@property (strong, nonatomic) NSString *albumID;
@property (strong, nonatomic) NSString *descrip;
@property (strong, nonatomic) NSString *size;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSMutableArray *photos;
@property (assign, nonatomic) OLTVPhotoAlbumState state;

- (instancetype)initWithResponse:(NSDictionary *)response;

- (instancetype)initAlbumWithAllPhotos:(NSMutableArray *)photos
                               ownerID:(NSString *)ownerID
                                  size:(NSString *)size;

@end
