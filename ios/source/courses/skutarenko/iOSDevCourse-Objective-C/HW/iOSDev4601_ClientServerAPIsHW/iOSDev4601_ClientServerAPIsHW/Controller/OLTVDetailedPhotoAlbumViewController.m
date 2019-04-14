//
//  OLTVDetailedPhotoAlbumViewController.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 09/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVDetailedPhotoAlbumViewController.h"

//Model
#import "../Model/OLTVPhotoAlbum.h"
#import "../Model/OLTVPhoto.h"

//API
#import "../API/OLTVAPIManager.h"

//Consts
static NSString *const photoCellIdentifier = @"photoCell";

//Libs
#import "../Libs/UIKit+AFNetworking/UIImageView+AFNetworking.h"

//UI
#import "../Cells/OLTVDetailedPhotoCollectionViewCell.h"

@interface OLTVDetailedPhotoAlbumViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) UIProgressView *progressView;
@property (weak, nonatomic) UILabel *progressLabel;
@property (weak, nonatomic) UIAlertController *progressAlert;

@property (assign, nonatomic) BOOL loadingData;
@property (assign, nonatomic) BOOL newPhotoLoaded;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)actionAddPhoto:(UIBarButtonItem *)sender;

@end

@implementation OLTVDetailedPhotoAlbumViewController

#pragma mark - View lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupProperties];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Setups

- (void)setupProperties {
  self.navigationItem.title = self.album.title;
  self.loadingData = NO;
  self.newPhotoLoaded = NO;
}

#pragma mark - API

- (void)updatePhotoAlbum:(OLTVPhotoAlbum *)photoAlbum {
  NSInteger requestCount = photoAlbum.photos.count < 50 ? 50 : 5;
  NSInteger offset = photoAlbum.photos.count;
  
  if (self.newPhotoLoaded) {
    self.newPhotoLoaded = NO;
    [photoAlbum.photos removeAllObjects];
    requestCount = 50;
    offset = 0;
  }
  
  if ([photoAlbum.title isEqualToString:@"All Photos"]) {
    if (!self.loadingData) {
      self.loadingData = YES;
      [[OLTVAPIManager sharedManager]
       getPhotoAlbumWithAllPhotosWithOwnerID:self.album.ownerID
       offset:offset
       count:requestCount
       completion:^(NSArray *photos, NSString *size, NSError *error) {
         if (error) {
           NSLog(@"%@ getPhotoAlbumWithAllPhotosWithOwnerID error = %@", [self class], [error localizedDescription]);
         } else {

           [photoAlbum.photos addObjectsFromArray:photos];
           self.loadingData = NO;
           [self.collectionView reloadData];

         }
       }];
    }
    
  } else {
    
    if (!self.loadingData) {
      self.loadingData = YES;
      [[OLTVAPIManager sharedManager]
       getPhotosWithOwnerID:photoAlbum.ownerID
       albumID:photoAlbum.albumID
       offset:offset
       count:requestCount
       completion:^(NSArray *photos, NSError *error) {
         if (error) {
           NSLog(@"updatePhotoAlbumFromServer error = %@", [error localizedDescription]);
         } else {
           
           [photoAlbum.photos addObjectsFromArray:photos];
           self.loadingData = NO;
           [self.collectionView reloadData];
           
         }
       }];
    }
  }
}

#pragma mark - Actions

- (IBAction)actionAddPhoto:(UIBarButtonItem *)sender {
  [self showAlert];
}

#pragma mark - Helper methods

- (void)showProgressAlert {
  
  UIAlertController *alert =
  [UIAlertController
   alertControllerWithTitle:@""
   message:@""
   preferredStyle:UIAlertControllerStyleAlert];
  self.progressAlert = alert;
  
  UIAlertAction *hide =
  [UIAlertAction
   actionWithTitle:@"Hide alert"
   style:UIAlertActionStyleDestructive
   handler:^(UIAlertAction * _Nonnull action) {
     
   }];
  
  UIAlertAction *cancel =
  [UIAlertAction
   actionWithTitle:@"Cancel"
   style:UIAlertActionStyleCancel
   handler:^(UIAlertAction * _Nonnull action) {
     
   }];
  
  [alert addAction:hide];
  [alert addAction:cancel];
  
  [self presentViewController:alert animated:YES completion:^{
    
    //setup progress view
    CGFloat pvX = 8.f;
    CGFloat pvY = CGRectGetMidY(alert.view.bounds);
    CGFloat pvWidth = CGRectGetWidth(alert.view.frame) - pvX * 2.f;
    CGRect pvRect = CGRectMake(pvX, pvY,  pvWidth, 2.f);
    UIProgressView *pv = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    pv.frame = pvRect;
    pv.progress = 0.0f;
    pv.tintColor = [UIColor blueColor];
    [alert.view addSubview:pv];
    self.progressView = pv;
    
    //setup progress label
    CGFloat plHeight = 20.f;
    CGFloat plX = 8.f;
    CGFloat plY = CGRectGetMidY(alert.view.bounds) - plHeight - plX;
    CGFloat plWidth = CGRectGetWidth(alert.view.frame) - plX * 2.f;
    CGRect plRect = CGRectMake(plX, plY, plWidth, plHeight);
    UILabel *pl = [[UILabel alloc] initWithFrame:plRect];
    pl.textAlignment = NSTextAlignmentCenter;
    pl.font = [UIFont systemFontOfSize:15.f];
    [alert.view addSubview:pl];
    self.progressLabel = pl;
    
  }];
}

- (void)showProgress:(CGFloat)progress {
  dispatch_async(dispatch_get_main_queue(), ^{
    self.progressView.progress = progress;
    self.progressLabel.text = [NSString stringWithFormat:@"%.0f%% completed", progress * 100];
  });
}

#pragma mark - Photo picker

- (void)showAlert {
  UIAlertController *alert =
  [UIAlertController
   alertControllerWithTitle:@"Add Photo"
   message:@"Choose the method"
   preferredStyle:UIAlertControllerStyleActionSheet];
  
  UIAlertAction *libraryAction =
  [UIAlertAction
   actionWithTitle:@"Library"
   style:UIAlertActionStyleDefault
   handler:^(UIAlertAction * _Nonnull action) {
     [self photoFromLibrary];
   }];
  
  UIAlertAction *cameraAction =
  [UIAlertAction
   actionWithTitle:@"Camera"
   style:UIAlertActionStyleDefault
   handler:^(UIAlertAction * _Nonnull action) {
     [self photoFromCamera];
   }];
  
  [alert addAction:libraryAction];
  [alert addAction:cameraAction];
  
  [self presentViewController:alert animated:YES completion:nil];
}

- (void)photoFromLibrary {
  UIImagePickerController *vc = [[UIImagePickerController alloc] init];
  vc.delegate = self;
  vc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
  [self presentViewController:vc animated:YES completion:nil];
}

- (void)photoFromCamera {
  UIImagePickerController *vc = [[UIImagePickerController alloc] init];
  vc.delegate = self;
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    vc.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:vc animated:YES completion:nil];
  
  } else {
    
    UIAlertController *alertVC =
    [UIAlertController
     alertControllerWithTitle:@"No Camera Available"
     message:@""
     preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOK =
    [UIAlertAction
     actionWithTitle:@"OK"
     style:UIAlertActionStyleDefault
     handler:nil];
    
    [alertVC addAction:actionOK];
    [self presentViewController:alertVC animated:YES completion:nil];
  }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
  UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
  
  [[OLTVAPIManager sharedManager]
   uploadPhoto:pickedImage
   album:self.album.albumID
   group:self.album.ownerID
   progress:^(CGFloat progress) {
     [self showProgress:progress];
   } completion:^(NSError *error) {
     if (error) {
       NSLog(@"%@ uploadPhoto error = %@", [self class], [error localizedDescription]);
     } else {
       [self.progressAlert dismissViewControllerAnimated:YES completion:nil];
       self.newPhotoLoaded = YES;
       [self updatePhotoAlbum:self.album];
     }
   }];
  
  [picker dismissViewControllerAnimated:YES completion:nil];
  [self showProgressAlert];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.album.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  OLTVDetailedPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoCellIdentifier forIndexPath:indexPath];
  OLTVPhoto *photo = self.album.photos[indexPath.item];
  
  NSURLRequest *request = [NSURLRequest requestWithURL:photo.photoURL];
  UIImage *placeholder = [UIImage imageNamed:@"userAvatarPlaceholder"];
  [cell.photoImageView
   setImageWithURLRequest:request
   placeholderImage:placeholder
   success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
     cell.photoImageView.image = image;
     [cell.photoImageView layoutSubviews];
   }
   failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
     NSLog(@"%@ setImageWithURLRequest error = %@", [self class], [error localizedDescription]);
   }];
  
  return cell;
}

#pragma - mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  //OLTVPhoto *photo = self.album.photos[indexPath.item];
  CGFloat viewWidth = CGRectGetWidth(self.view.bounds) / 3;
  CGFloat width = viewWidth - 16.f;//75;//[photo.width floatValue] / 8;
  CGFloat height = 75;//[photo.height floatValue] / 4;
  CGSize size = CGSizeMake(width, height);
  return size;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGFloat offsetX = scrollView.contentOffset.x;
  CGFloat frame = scrollView.frame.size.height;
  CGFloat content = scrollView.contentSize.height;
  if ((offsetX + frame) >= content - frame*2) {
    [self updatePhotoAlbum:self.album];
  }
}

@end














