//
//  OLTVWallTableViewController.m
//  iOSDev4501_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 08/06/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVWallTableViewController.h"

//API
#import "../API/OLTVAPIServerManager.h"

//Model
#import "../Model/OLTVWall.h"
#import "../Model/OLTVDetailedUser.h"

//UI
#import "../Cells/OLTVTextTableViewCell.h"
#import "../Cells/OLTVPhotoTableViewCell.h"
#import "../Cells/OLTVLinkTableViewCell.h"

//Libs
#import "../Libs/UIKit+AFNetworking/UIImageView+AFNetworking.h"

//Categories
#import "UITableViewCell+HeightForText.h"

@interface OLTVWallTableViewController ()
@property (strong, nonatomic) NSMutableArray *wall;
@end

@implementation OLTVWallTableViewController

#pragma mark - View lifecycles

- (void)viewDidLoad {
  [super viewDidLoad];
  self.wall = [NSMutableArray array];
  [self getWallFromServer];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - API

- (void)getWallFromServer {
  [[OLTVAPIServerManager sharedManager]
   getWallWithUserID:self.userID
   offset:[self.wall count]
   count:10
   onSuccess:^(NSArray *wall) {
     [self.wall addObjectsFromArray:wall];
     [self.tableView reloadData];
   }
   onFailure:^(NSError *error) {
     NSLog(@"error = %@", error);
   }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.wall count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  OLTVWall *wall = self.wall[indexPath.row];
  
  static NSString *textCellIdentifier = @"textCell";
  static NSString *photoCellIdentifier = @"photoCell";
  static NSString *linkCellIdentifier = @"linkCell";
  
  OLTVTextTableViewCell *textCell = [tableView dequeueReusableCellWithIdentifier:textCellIdentifier];
  OLTVPhotoTableViewCell *photoCell = [tableView dequeueReusableCellWithIdentifier:photoCellIdentifier];
  OLTVLinkTableViewCell *linkCell = [tableView dequeueReusableCellWithIdentifier:linkCellIdentifier];
  
  if (wall.type == OLTVWallTypeText) {
  
    //user photo
    __weak OLTVTextTableViewCell *weakTextCell = textCell;
    [[OLTVAPIServerManager sharedManager]
     getUserWithID:wall.from_id
     onSuccess:^(OLTVDetailedUser *user) {
       
       weakTextCell.userFullNameLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
       
       NSURLRequest *urlRequest = [NSURLRequest requestWithURL:user.imageURL];
       [weakTextCell.userPhoto
        setImageWithURLRequest:urlRequest
        placeholderImage:nil
        success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
          
          weakTextCell.userPhoto.image = image;
          
        }
        failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
          NSLog(@"error = %@", [error localizedDescription]);
        }];
     }
     onFailure:^(NSError *error) {
       NSLog(@"error = %@", [error localizedDescription]);
     }];
    
    //date label
    textCell.dateLabel.text = wall.dateString;
    
    //wall text
    textCell.wallTextLabel.text = wall.text;
    
    return textCell;
    
  } else if (wall.type == OLTVWallTypePhoto) {
    
    //user photo && userFullNameLabel
    __weak OLTVPhotoTableViewCell *weakPhotoCell = photoCell;
    [[OLTVAPIServerManager sharedManager]
     getUserWithID:wall.from_id
     onSuccess:^(OLTVDetailedUser *user) {
       
       weakPhotoCell.userFullNameLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
       
       NSURLRequest *userPhotoUrlRequest = [NSURLRequest requestWithURL:user.imageURL];
       [weakPhotoCell.userPhoto
        setImageWithURLRequest:userPhotoUrlRequest
        placeholderImage:nil
        success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
          
          weakPhotoCell.userPhoto.image = image;
          [weakPhotoCell layoutSubviews];
          
        }
        failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
          NSLog(@"error = %@", [error localizedDescription]);
        }];
       
     }
     onFailure:^(NSError *error) {
       NSLog(@"error = %@", [error localizedDescription]);
     }];
    
    //wallPhoto
    NSURLRequest *wallPhotoUrlRequest = [NSURLRequest requestWithURL:wall.photoURL];
    [weakPhotoCell.wallPhoto
     setImageWithURLRequest:wallPhotoUrlRequest
     placeholderImage:nil
     success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
       
       weakPhotoCell.wallPhoto.image = image;
       [weakPhotoCell layoutSubviews];
       
     }
     failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
       NSLog(@"error = %@", [error localizedDescription]);
     }];
    
    //wallTextLabel
    photoCell.wallTextLabel.text = wall.text;
    
    //dateLabel
    photoCell.dateLabel.text = wall.dateString;
    
    return photoCell;
    
  } else if (wall.type == OLTVWallTypeLink) {
    
    //userPhoto
    __weak OLTVLinkTableViewCell *weakLinkCell = linkCell;
    NSURLRequest *userPhotoUrlRequest = [NSURLRequest requestWithURL:wall.photoURL];
    [weakLinkCell.userPhoto
     setImageWithURLRequest:userPhotoUrlRequest
     placeholderImage:nil
     success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
       
       weakLinkCell.userPhoto.image = image;
       [weakLinkCell layoutSubviews];
       
     }
     failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
       NSLog(@"error = %@", [error localizedDescription]);
     }];
    
    //userFullName
    [[OLTVAPIServerManager sharedManager]
     getUserWithID:wall.from_id
     onSuccess:^(OLTVDetailedUser *user) {
       
       weakLinkCell.userFullNameLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
       
     }
     onFailure:^(NSError *error) {
       NSLog(@"error = %@", [error localizedDescription]);
     }];
    
    //date label
    linkCell.dateLabel.text = wall.dateString;
    
    //title label
    linkCell.titleLabel.text = wall.linkTitle;
    
    //caption label
    linkCell.captionLabel.text = wall.linkCaption;
    
    //web view
    linkCell.webView = nil;
    
    return linkCell;
    
  }
  
  return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
  
  if ([cell isKindOfClass:[OLTVTextTableViewCell class]]) {
    
    OLTVTextTableViewCell *textCell = (OLTVTextTableViewCell *)cell;
    return [textCell heightForText:textCell.wallTextLabel.text] + CGRectGetHeight(textCell.userPhoto.frame);
    
  } else if ([cell isKindOfClass:[OLTVPhotoTableViewCell class]]) {
    
    OLTVPhotoTableViewCell *photoCell = (OLTVPhotoTableViewCell *)cell;
    CGFloat userPhotoHeight = CGRectGetHeight(photoCell.userPhoto.frame);
    CGFloat textHeight = [photoCell heightForText:photoCell.wallTextLabel.text];
    CGFloat wallPhotoHeight = photoCell.wallPhoto.image.size.height;

    return userPhotoHeight + textHeight + wallPhotoHeight;
  }

  return 200.f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == [self.wall count] - 5) {
    [self getWallFromServer];
  }
}

@end
