//
//  MRQDataModel.h
//  31-32_UITableViewEditing_RestoProg
//
//  Created by Oleg Tverdokhleb on 29.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MRQDataModel : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) CGFloat averageGrade;

@property (strong, nonatomic) NSArray *students;
@property (strong, nonatomic) NSString *name;

+ (MRQDataModel *) initialStudent;
+ (MRQDataModel *) initialGroupWithIndex:(NSInteger) index;

@end
