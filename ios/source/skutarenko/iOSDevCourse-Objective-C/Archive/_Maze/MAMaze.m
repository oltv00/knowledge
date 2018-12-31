//
//  ASMaze.m
//  MazeAdventure
//
//  Created by Oleksii Skutarenko on 30.11.13.
//  Copyright (c) 2013 Alex Skutarenko. All rights reserved.
//

#import "MAMaze.h"

static NSString* kLocationCoordinate    = @"Coordinate";
static NSString* kLocationType          = @"Type";
static NSString* kLocationTypeCorridor  = @"Corridor";
static NSString* kLocationTypeEntrance  = @"Entrance";
static NSString* kLocationTypeTreasure  = @"Treasure";

@interface MAMaze ()

@property (nonatomic, strong) NSDictionary* locationsMap;
@property (assign, nonatomic, readonly) CGPoint currentPoint;
@property (assign, nonatomic, readonly) NSInteger movesNumber;
@end

@implementation MAMaze

- (id)init
{
    self = [super init];
    if (self) {
        
        
        NSMutableDictionary* map = [NSMutableDictionary dictionary];
        
        NSString* path = [[NSBundle mainBundle] pathForResource:@"Maze" ofType:@"plist"];
        
        // load dictionary from file
        NSDictionary* locationsDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        
        if (!locationsDictionary) {
            NSLog(@"Maze.plist not found");
            return nil;
        }
        
        NSArray* locations = [locationsDictionary objectForKey:@"Locations"];
        
        CGRect mazeRect = CGRectZero;
        
        // cache all locations to map
        for (NSDictionary* dict in locations) {
            
            NSString* coordinateString = [dict objectForKey:kLocationCoordinate];
            
            CGPoint coordinatePoint = CGPointFromString(coordinateString);
            
            CGRect cell = CGRectZero;
            cell.size = CGSizeMake(1, 1);
            cell.origin = coordinatePoint;
            
            mazeRect = CGRectUnion(mazeRect, cell);
            
            if ([map objectForKey:coordinateString]) {
                NSLog(@"DUPLICATE LOCATION AT COORDINATE %@", coordinateString);
                continue;
            }
            
            NSString* locationTypeString = [dict objectForKey:kLocationType];
            
            MALocationType locationType = MALocationTypeCorridor;
            
            if ([locationTypeString isEqualToString:kLocationTypeCorridor]) {
                locationType = MALocationTypeCorridor;
            } else if ([locationTypeString isEqualToString:kLocationTypeTreasure]) {
                locationType = MALocationTypeTreasure;
            } else if ([locationTypeString isEqualToString:kLocationTypeEntrance]) {
                _currentPoint = coordinatePoint;
                _entranceCoordinate = coordinatePoint;
                locationType = MALocationTypeEntrance;
            } else {
                NSLog(@"WRONG LOCATION TYPE AT COORDINATE %@", coordinateString);
                continue;
            }
            
            MAMazeLocation* mazeLocation = [[MAMazeLocation alloc] init];
            mazeLocation.locationType = locationType;
            
            [map setObject:mazeLocation forKey:NSStringFromCGPoint(coordinatePoint)];
        }
        
        // set directions to every location
        for (NSString* coordinateString in [map allKeys]) {
            
            MAMazeLocation* mazeLocation = [map objectForKey:coordinateString];
            
            MADirection directions = 0;
            
            if ([map objectForKey:[self pointString:coordinateString applyDirection:MADirectionWest]]) {
                directions |= MADirectionWest;
            }
            
            if ([map objectForKey:[self pointString:coordinateString applyDirection:MADirectionEast]]) {
                directions |= MADirectionEast;
            }
            
            if ([map objectForKey:[self pointString:coordinateString applyDirection:MADirectionNorth]]) {
                directions |= MADirectionNorth;
            }
            
            if ([map objectForKey:[self pointString:coordinateString applyDirection:MADirectionSouth]]) {
                directions |= MADirectionSouth;
            }
            
            mazeLocation.directions = directions;
        }
        
        _mazeSize = mazeRect.size;
        self.locationsMap = map;
        
        NSLog(@"\nLocations:%@\nSize:%@\nEntrance: %@",
              map,
              NSStringFromCGSize(self.mazeSize),
              NSStringFromCGPoint(_entranceCoordinate));
    }
    return self;
}

- (NSString*) pointString:(NSString*) pointString applyDirection:(MADirection) direction {
    
    CGPoint point = CGPointFromString(pointString);
    
    switch (direction) {
        case MADirectionNorth:  point.y += 1; break;
        case MADirectionSouth:  point.y -= 1; break;
        case MADirectionWest:   point.x -= 1; break;
        case MADirectionEast:   point.x += 1; break;
        default: break;
    }
    
    return NSStringFromCGPoint(point);
}

- (MAMazeLocation*) moveToDirection:(MADirection) direction {
    
    _movesNumber++;
    
    NSString* currentCoordinate = NSStringFromCGPoint(_currentPoint);
    NSString* newCoordinate = [self pointString:currentCoordinate applyDirection:direction];
    
    if ([currentCoordinate isEqualToString:newCoordinate]) {
        return nil;
    } else {
        return [self.locationsMap objectForKey:newCoordinate];
    }
}

@end

@implementation MAMazeLocation

- (NSString*) stringFromLocationType:(MALocationType) type {
    
    switch (type) {
        case MALocationTypeCorridor:    return @"Corridor";
        case MALocationTypeEntrance:    return @"Entrance";
        case MALocationTypeTreasure:    return @"Treasure";
        default:                        return @"Wrong Type";
    }
}

- (NSString*) stringFromDirections:(MADirection) directions {
    
    NSMutableString* result = [NSMutableString string];
    
    if (directions & MADirectionWest) {
        [result appendString:@"West "];
    }
    if (directions & MADirectionEast) {
        [result appendString:@"East "];
    }
    if (directions & MADirectionNorth) {
        [result appendString:@"North "];
    }
    if (directions & MADirectionSouth) {
        [result appendString:@"South "];
    }
    
    if ([result length] > 0) {
        return [result substringToIndex:(int)[result length] -1];
    } else {
        return @"No Directions";
    }
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@, Directions: %@",
            [self stringFromLocationType:self.locationType],
            [self stringFromDirections:self.directions]];
}

@end