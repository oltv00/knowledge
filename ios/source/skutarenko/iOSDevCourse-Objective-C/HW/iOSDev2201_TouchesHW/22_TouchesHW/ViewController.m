//
//  ViewController.m
//  22_TouchesHW
//
//  Created by Oleg Tverdokhleb on 15.04.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) UIView *checkersBoard;
@property (weak, nonatomic) UIView *draggingView;
@property (assign, nonatomic) CGPoint touchOffset;
@property (assign, nonatomic) CGPoint startCellPosition;
@property (strong, nonatomic) NSMutableSet *checkers;
@property (strong, nonatomic) NSMutableSet *blackCells;
@property (strong, nonatomic) NSMutableSet *freeCells;
@end

@implementation ViewController

#pragma mark - LifeCycles
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initialProperties];
    [self initialBoard];
    [self initialCells];
    [self initialCheckers];
}

#pragma mark - Initial
- (void)initialProperties {
    self.checkers = [NSMutableSet set];
    self.blackCells = [NSMutableSet set];
    self.freeCells = [NSMutableSet set];
}

- (void)initialBoard {
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = width;
    CGRect checkersBoardRect = CGRectMake(x, y, width, height);
    UIView *checkersBoard = [[UIView alloc] initWithFrame:checkersBoardRect];
    checkersBoard.backgroundColor = [UIColor redColor];
    checkersBoard.center = self.view.center;
    checkersBoard.autoresizingMask =    UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin |
                                        UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:checkersBoard];
    self.checkersBoard = checkersBoard;
}

- (void)initialCells {
    //Создайте шахматное поле (8х8), используйте черные сабвьюхи
    CGFloat cellSize = CGRectGetWidth(self.view.frame) / 8;
    
    for (int string = 0; string < 8; string += 1) {
        for (int column = 0; column < 8; column += 1) {
            CGFloat x = column * cellSize;
            CGFloat y = string * cellSize;
            CGRect cellRect = CGRectMake(x, y, cellSize, cellSize);
            UIView *cellView = [[UIView alloc] initWithFrame:cellRect];
            cellView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
            
            if ((string % 2 == 0 && column % 2 == 0) || (string % 2 != 0 && column % 2 != 0)) {
                //white
                cellView.backgroundColor = [UIColor whiteColor];
            } else {
                //black
                cellView.backgroundColor = [UIColor blackColor];
                [self.blackCells addObject:cellView];
            }
            [self.checkersBoard addSubview:cellView];
        }
    }
}

- (void)initialCheckers {
    //Добавьте белые и красные шашки на черные клетки (используйте начальное расположение в шашках)
    CGFloat boardSize = CGRectGetWidth(self.view.frame);
    CGFloat checkerPosition = boardSize / 8;
    CGFloat checkerSize = boardSize / 10;
    
    for (int string = 0; string < 8; string += 1) {
        for (int column = 0; column < 8; column += 1) {
            CGFloat x = 1+(NSInteger)(column * checkerPosition + checkerSize / 10);
            CGFloat y = 1+(NSInteger)(string * checkerPosition + checkerSize / 10);
            CGRect checkerRect = CGRectMake(x, y, checkerSize, checkerSize);
            UIView *checkerView = [[UIView alloc] initWithFrame:checkerRect];
            checkerView.layer.cornerRadius = checkerSize / 2;
            
            [self.freeCells addObject:[NSValue valueWithCGPoint:checkerView.center]];
            if (!((string % 2 == 0 && column % 2 == 0) || (string % 2 != 0 && column % 2 != 0))) {
                if (string < 3) {
                    //top checkers
                    checkerView.backgroundColor = [UIColor whiteColor];
                    [self.checkersBoard addSubview:checkerView];
                    [self.checkers addObject:checkerView];
                    [self.freeCells removeObject:[NSValue valueWithCGPoint:checkerView.center]];
                } else if (string > 4) {
                    //bottom checkers
                    checkerView.backgroundColor = [UIColor redColor];
                    [self.checkersBoard addSubview:checkerView];
                    [self.checkers addObject:checkerView];
                    [self.freeCells removeObject:[NSValue valueWithCGPoint:checkerView.center]];
                }
            }
        }
    }
}

#pragma mark - Touches
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pointOnMainView = [touch locationInView:self.checkersBoard];
    UIView *touchView = [self.checkersBoard hitTest:pointOnMainView withEvent:event];
    
    if (![touchView isEqual:self.view]) {
        for (UIView *view in self.checkers) {
            if ([view isEqual:touchView]) {
                [self.freeCells addObject:[NSValue valueWithCGPoint:touchView.center]];
                self.draggingView = touchView;
                self.startCellPosition = self.draggingView.center;
                
                //offset
                CGPoint pointInside = [touch locationInView:self.draggingView];
                CGFloat dx = CGRectGetMidX(self.draggingView.bounds) - pointInside.x;
                CGFloat dy = CGRectGetMidY(self.draggingView.bounds) - pointInside.y;
                self.touchOffset = CGPointMake(dx, dy);
                
                //new center point
                CGFloat newX = pointOnMainView.x + dx;
                CGFloat newY = pointOnMainView.y + dy;
                CGPoint newCenterPoint = CGPointMake(newX, newY);
                
                self.draggingView.center = newCenterPoint;
                break;
            }
        }
    } else {
        self.draggingView = nil;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pointOnMainView = [touch locationInView:self.checkersBoard];
    if (self.draggingView) {
        CGFloat newX = pointOnMainView.x + self.touchOffset.x;
        CGFloat newY = pointOnMainView.y + self.touchOffset.y;
        CGPoint newCenterPoint = CGPointMake(newX, newY);
        self.draggingView.center = newCenterPoint;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if (self.draggingView) {
        //Шашки должны ставать в центр черных клеток.
        for (UIView *cell in self.blackCells) {
            CGPoint touchPoint = [touch locationInView:cell];
            
            //Ищем ячейку поля на которую устанавливаем dragging view
            if ([cell pointInside:touchPoint withEvent:event]) {
                for (NSValue *value in self.freeCells) {
                    if ([value isEqualToValue:[NSValue valueWithCGPoint:cell.center]]) {
                        [self.freeCells removeObject:[NSValue valueWithCGPoint:cell.center]];
                        self.draggingView.center = cell.center;
                        self.draggingView = nil;
                        return;
                    } else {
                        self.draggingView.center = self.startCellPosition;
                    }
                }
            } else {
                self.draggingView.center = self.startCellPosition;
            }
        }
    }
    self.draggingView = nil;
}

- (void)touchesCancelled:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    self.draggingView = nil;
}

#pragma mark _UNUSED_
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
