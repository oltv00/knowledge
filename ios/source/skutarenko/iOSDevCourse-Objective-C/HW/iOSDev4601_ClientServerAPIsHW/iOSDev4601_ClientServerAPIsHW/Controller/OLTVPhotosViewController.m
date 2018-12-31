//
//  OLTVPhotosViewController.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 05/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVPhotosViewController.h"

//Consts
static NSString *const photoAlbumTableCellIdentifier = @"photoAlbumTableCell";
static NSString *const photoCollectionCellIdentifier = @"photoCollectionCell";

static NSString *const showDetailedPhotoAlbumSegue = @"showDetailedPhotoAlbum";

static NSInteger const requestCount = 5.f;

//API
#import "../API/OLTVAPIManager.h"

//UI
#import "../Cells/OLTVPhotoAlbumTableViewCell.h"
#import "../Cells/OLTVPhotoCollectionViewCell.h"

//Model
#import "../Model/OLTVPhotoAlbum.h"
#import "../Model/OLTVPhoto.h"

//Libs
#import "../Libs/UIKit+AFNetworking/UIImageView+AFNetworking.h"

//Controllers
#import "../Controller/OLTVDetailedPhotoAlbumViewController.h"

@interface OLTVPhotosViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *photoAlbums;
@property (strong, nonatomic) NSMutableDictionary *contentOffsetDictionary;
@property (assign, nonatomic) BOOL loadingData;
@property (strong, nonatomic) OLTVPhotoAlbum *allPhotos;
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation OLTVPhotosViewController

#pragma mark - View lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //Setups
  [self setupProperties];
  
  //API
  [self getAllPhotosFromServer];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Helper methods

- (void)collectionViewContentUpdate:(UICollectionView *)collectionView {
  CGFloat offsetX = collectionView.contentOffset.x;
  CGFloat frame = collectionView.frame.size.width;
  CGFloat content = collectionView.contentSize.width;
  if ((offsetX + frame) >= content - frame) {
    OLTVPhotoAlbum *photoAlbum = self.photoAlbums[collectionView.tag];
    [self updatePhotoAlbum:photoAlbum inCollectionView:collectionView];
  }
}

#pragma mark - Setups

- (void)setupProperties {
  self.photoAlbums = [NSMutableArray array];
  self.contentOffsetDictionary = [NSMutableDictionary dictionary];
  self.loadingData = NO;
}

#pragma mark - API

- (void)getAllPhotosFromServer {
  if (!self.loadingData) {
    self.loadingData = YES;
    [[OLTVAPIManager sharedManager]
     getPhotoAlbumWithAllPhotosWithOwnerID:self.ownerID
     offset:self.allPhotos ? self.allPhotos.photos.count : 0
     count:requestCount
     completion:^(NSArray *photos, NSString *size, NSError *error) {
       if (error) {
         NSLog(@"getPhotoAlbumWithAllPhotosWithOwnerID error = %@", [error localizedDescription]);
       } else {
         
         if (!self.allPhotos) {
           OLTVPhotoAlbum *allPhotos = [[OLTVPhotoAlbum alloc]
                                        initAlbumWithAllPhotos:(NSMutableArray *)photos
                                        ownerID:self.ownerID size:size];
           self.allPhotos = allPhotos;
           [self.photoAlbums addObject:allPhotos];
           self.loadingData = NO;
           [self getPhotoAlbumsFromServer];
         } else {
           [self.allPhotos.photos addObjectsFromArray:photos];
           [self.collectionView reloadData];
           self.loadingData = NO;
         }
       }
     }];
  }
}

- (void)getPhotoAlbumsFromServer {
  if (!self.loadingData) {
    self.loadingData = YES;
    [[OLTVAPIManager sharedManager]
     getPhotoAlbumsWithOwnerID:self.ownerID
     offset:self.allPhotos ? self.photoAlbums.count - 1 : self.photoAlbums.count
     count:requestCount
     completion:^(NSArray *photoAlbums, NSError *error) {
       if (error) {
         NSLog(@"getPhotoAlbumsWithOwnerID error = %@", [error localizedDescription]);
       } else {
         
         [self.photoAlbums addObjectsFromArray:photoAlbums];
         self.loadingData = NO;
         [self.tableView reloadData];
         
       }
     }];
  }
}

- (void)updatePhotoAlbum:(OLTVPhotoAlbum *)photoAlbum
        inCollectionView:(UICollectionView *)collectionView
{
  if ([photoAlbum.title isEqualToString:@"All Photos"]) {
    
    self.collectionView = collectionView;
    [self getAllPhotosFromServer];
    
  } else {
    
    if (!self.loadingData) {
      self.loadingData = YES;
      [[OLTVAPIManager sharedManager]
       getPhotosWithOwnerID:photoAlbum.ownerID
       albumID:photoAlbum.albumID
       offset:photoAlbum.photos.count
       count:requestCount
       completion:^(NSArray *photos, NSError *error) {
         if (error) {
           NSLog(@"updatePhotoAlbumFromServer error = %@", [error localizedDescription]);
         } else {
           
           [photoAlbum.photos addObjectsFromArray:photos];
           self.loadingData = NO;
           [collectionView reloadData];
           
         }
       }];
    }
  }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:showDetailedPhotoAlbumSegue]) {
    if ([sender isKindOfClass:[OLTVPhotoAlbum class]]) {
      OLTVDetailedPhotoAlbumViewController *vc = segue.destinationViewController;
      OLTVPhotoAlbum *album = sender;
      vc.album = album;
    }
  }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.photoAlbums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  OLTVPhotoAlbumTableViewCell *photoAlbumCell = [tableView dequeueReusableCellWithIdentifier:photoAlbumTableCellIdentifier];
  
  OLTVPhotoAlbum *photoAlbum = self.photoAlbums[indexPath.row];
  photoAlbumCell.titleLabel.text = photoAlbum.title;
  photoAlbumCell.countLabel.text = [NSString stringWithFormat:@"%@ photos", photoAlbum.size];
  
  return photoAlbumCell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  OLTVPhotoAlbum *album = self.photoAlbums[indexPath.row];
  [self performSegueWithIdentifier:showDetailedPhotoAlbumSegue sender:album];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([cell isKindOfClass:[OLTVPhotoAlbumTableViewCell class]]) {
    OLTVPhotoAlbumTableViewCell *aCell = (OLTVPhotoAlbumTableViewCell *)cell;
    [aCell setCollectionViewDataSourceDelegate:self forRow:indexPath.row];
    
    NSInteger index = aCell.collectionView.tag;
    CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
    [aCell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
  }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([cell isKindOfClass:[OLTVPhotoAlbumTableViewCell class]]) {
    OLTVPhotoAlbumTableViewCell *aCell = (OLTVPhotoAlbumTableViewCell *)cell;
    
    CGFloat horizontalOffset = aCell.collectionView.contentOffset.x;
    NSInteger index = aCell.collectionView.tag;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
  }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  OLTVPhotoAlbum *album = self.photoAlbums[collectionView.tag];
  if (album.state != OLTVPhotoAlbumStateDownloaded) {
    [self updatePhotoAlbum:album inCollectionView:collectionView];
  }
  return album.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  OLTVPhotoCollectionViewCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:photoCollectionCellIdentifier forIndexPath:indexPath];
  
  OLTVPhotoAlbum *album = self.photoAlbums[collectionView.tag];
  OLTVPhoto *photo = album.photos[indexPath.item];
  
  NSURLRequest *request = [NSURLRequest requestWithURL:photo.photoURL];
  UIImage *placeholder = [UIImage imageNamed:@"userAvatarPlaceholder"];
  [photoCell.photoImageView
   setImageWithURLRequest:request
   placeholderImage:placeholder
   success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
     photoCell.photoImageView.image = image;
     [photoCell.photoImageView layoutSubviews];
   }
   failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
     NSLog(@"error = %@", [error localizedDescription]);
   }];
  
  return photoCell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (!self.loadingData && [scrollView isKindOfClass:[UICollectionView class]]) {
    UICollectionView *collectionView = (UICollectionView *)scrollView;
    [self collectionViewContentUpdate:collectionView];
  }
}

@end























