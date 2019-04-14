//
//  ASMaze.h
//  MazeAdventure
//
//  Created by Oleksii Skutarenko on 30.11.13.
//  Copyright (c) 2013 Alex Skutarenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MADirectionNorth    = 1 << 0,
    MADirectionSouth    = 1 << 1,
    MADirectionWest     = 1 << 2,
    MADirectionEast     = 1 << 3
} MADirection;

typedef enum {
    MALocationTypeCorridor,
    MALocationTypeEntrance,
    MALocationTypeTreasure,
} MALocationType;

@class MAMazeLocation;

@interface MAMaze : NSObject

@property (assign, nonatomic, readonly) CGSize mazeSize;
@property (assign, nonatomic, readonly) CGPoint entranceCoordinate;
@property (assign, nonatomic, readonly) NSInteger numberOfTreasures;

- (MAMazeLocation*) moveToDirection:(MADirection) direction;

@end


@interface MAMazeLocation : NSObject

@property (assign, nonatomic) MADirection directions;
@property (assign, nonatomic) MALocationType locationType;

@end
