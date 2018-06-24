//
//  MRQSubscriptionsTableViewController.m
//  45_ClientServerAPIsBasicsHWRestoProg
//
//  Created by Oleg Tverdokhleb on 23.01.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "MRQServerManager.h"
#import "UIImageView+AFNetworking.h"

#import "MRQSubscriptionsTableViewController.h"

#import "MRQSubscriptor.h"

@interface MRQSubscriptionsTableViewController ()

@property (strong, nonatomic) NSMutableArray *subsArray;
@property (assign, nonatomic) NSInteger countOfSubs;

@end

@implementation MRQSubscriptionsTableViewController

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initial];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initial {
    self.subsArray = [NSMutableArray array];
}

- (void)setup {
    [self getSubsFromServerWithUserID:self.userID];
}

#pragma mark - API

- (void)getSubsFromServerWithUserID:(NSInteger) userID {
    [[MRQServerManager sharedManager]
     getSubscriptionsWithUserID:userID
     offset:[self.subsArray count]
     count:20
     onSuccess:^(NSArray *subs, NSInteger countOfSubs) {
         
         self.countOfSubs = countOfSubs;
         [self.subsArray addObjectsFromArray:subs];
         
         NSInteger index = [self.subsArray count] - [subs count];
         NSMutableArray *newPaths = [NSMutableArray array];
         
         for (;index < [self.subsArray count]; index++) {
             [newPaths addObject:[NSIndexPath indexPathForRow:index inSection:0]];
         }
         
         [self.tableView beginUpdates];
         [self.tableView insertRowsAtIndexPaths:newPaths
                               withRowAnimation:UITableViewRowAnimationTop];
         [self.tableView endUpdates];
     }
     onFailure:^(NSError *error) {
         NSLog(@"%@", [error localizedDescription]);
     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.subsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"subs"];
    
    MRQSubscriptor *sub = [self.subsArray objectAtIndex:indexPath.row];
    
    aCell.textLabel.text = [NSString stringWithFormat:@"%@ %@", sub.firstName, sub.lastName];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:sub.imageURL];
    
    __weak UITableViewCell *weakCell = aCell;
    
    [aCell.imageView
     setImageWithURLRequest:request
     placeholderImage:[UIImage imageNamed:@"placeholder_image.png"]
     success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
         weakCell.imageView.image = image;
         [weakCell layoutSubviews];
         
         weakCell.imageView.layer.cornerRadius = weakCell.imageView.frame.size.width / 2;
         weakCell.clipsToBounds = YES;
     }
     failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
         NSLog(@"%@", [error localizedDescription]);
     }];
    
    return aCell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [self.subsArray count] - 5) {
        //[self getSubsFromServerWithUserID:self.userID];
    }
}

@end
