//
//  OLTVPhotoTableViewCell.m
//  iOSDev4601_ClientServerAPIsHW
//
//  Created by Oleg Tverdokhleb on 05/07/16.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "OLTVPhotoAlbumTableViewCell.h"

@implementation OLTVPhotoAlbumTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate forRow:(NSInteger)row {
  self.collectionView.dataSource = dataSourceDelegate;
  self.collectionView.delegate = dataSourceDelegate;
  self.collectionView.tag = row;
  [self.collectionView reloadData];
}

@end
