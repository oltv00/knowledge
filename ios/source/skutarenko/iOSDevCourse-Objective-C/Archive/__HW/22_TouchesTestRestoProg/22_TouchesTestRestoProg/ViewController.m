//
//  ViewController.m
//  22_TouchesTestRestoProg
//
//  Created by Oleg Tverdokhleb on 07.11.15.
//  Copyright © 2015 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIView *boardView;

@property (weak, nonatomic) UIView *draggingView;
@property (assign, nonatomic) CGPoint touchOffset;
@property (assign, nonatomic) CGPoint lastCenterOfChecker;

@property (strong, nonatomic) NSMutableSet *setOfAllCheckers;
@property (strong, nonatomic) NSMutableSet *setOfAllBlackFields;
@property (strong, nonatomic) NSMutableSet *setOfAllWhiteFields;

@end

@implementation ViewController

#pragma mark - General Methods in ViewController;

- (void)viewDidLoad {[super viewDidLoad];}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //Инициализация.
    self.setOfAllCheckers = [[NSMutableSet alloc] init];
    self.setOfAllBlackFields = [[NSMutableSet alloc] init];
    self.setOfAllWhiteFields = [[NSMutableSet alloc] init];
    
    [self boardCreate];
}

#pragma mark - Touches Methods;

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint pointOnBoardView = [touch locationInView:self.boardView];
    UIView *selectedChecker = [self.boardView hitTest:pointOnBoardView withEvent:event];
    
    for (UIView *checker in self.setOfAllCheckers) {
        if ([selectedChecker isEqual:checker]) { //Если выбранный checker соответствует checker'у, который есть в NSMutableSet;
            self.draggingView = checker;
            self.lastCenterOfChecker = checker.center;
            [self.boardView bringSubviewToFront:self.draggingView];
            CGPoint touchPoint = [touch locationInView:self.draggingView];
            self.touchOffset = CGPointMake(CGRectGetMidX(self.draggingView.bounds) - touchPoint.x,
                                           CGRectGetMidY(self.draggingView.bounds) - touchPoint.y);
            
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.draggingView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
                                 self.draggingView.alpha = 0.8f;
                             }];
            break;
        } else {
            self.draggingView = nil;
        }
    }
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if (self.draggingView) {
        UITouch *touch = [touches anyObject];
        CGPoint pointOnBoardView = [touch locationInView:self.boardView];
        CGPoint correction = CGPointMake(pointOnBoardView.x + self.touchOffset.x,
                                         pointOnBoardView.y + self.touchOffset.y);
        self.draggingView.center = correction;
    }
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // Можно так, а можно создать CGPoint, и использовать его в методе CGRectContainsPoint вместо self.draggingView.center
    // Тогда чтобы переместить checker, достаточно будет поместить touchPoint на другую blackField

    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.boardView];
    UIView *view = [self.boardView hitTest:point withEvent:event];
    
    for (view in self.setOfAllBlackFields) {
        [self.setOfAllBlackFields o]
        if (view isEqual:[self.setOfAllBlackFields objectEnumerator]) {
            NSLog(@"working!");
        }
    }
    
    self.draggingView = nil;
    
    /*
    for (UIView *blackField in self.setOfAllBlackFields) {
        if (CGRectContainsPoint(blackField.frame, self.draggingView.center)) {
            self.draggingView.center = blackField.center;
            break;
        } else {
            for (UIView *whiteField in self.setOfAllWhiteFields) {
                if (CGRectContainsPoint(whiteField.frame, self.draggingView.center)) {
                    self.draggingView.center = self.lastCenterOfChecker;
                    break;
                }
            }
        }
    }
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.draggingView.transform = CGAffineTransformIdentity;
                         self.draggingView.alpha = 1.f;
                     }];
    self.draggingView = nil;
    */
}

- (void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.draggingView = nil;
}

#pragma mark - Board Create Methods;

- (void) boardCreate {
    
    //Инициализация доски.
    CGFloat boardViewProportions = self.view.frame.size.width;
    CGRect boardRect = CGRectMake(0, 0, boardViewProportions, boardViewProportions);
    UIView *boardView = [[UIView alloc] initWithFrame:boardRect];
    boardView.backgroundColor = [UIColor blackColor];
    boardView.center = self.view.center;
    boardView.autoresizingMask =    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                                    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    //Инициализация сеттера и геттера для self.boardView;
    self.boardView = boardView;
    self.boardView.layer.borderColor = [UIColor blackColor].CGColor;
    self.boardView.layer.borderWidth = 2.f;
    [self.view addSubview:self.boardView];
    
    //Инициализация CGRect под поля.
    CGRect fieldRect = CGRectMake(0, 0, boardViewProportions / 8, boardViewProportions / 8);
    
    //Создание черных полей и фигур.
    for (NSInteger string = 0; string < 8; string++){
        for (NSInteger column = 0; column < 8; column++){
            if (((string % 2) != 0 && (column % 2) == 0) || ((string % 2) == 0 && (column % 2) != 0)){
                
                //Создание черных полей.
                UIView *fieldView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(fieldRect) * column,
                                                                             CGRectGetWidth(fieldRect) * string,
                                                                             CGRectGetWidth(fieldRect),
                                                                             CGRectGetWidth(fieldRect))];
                fieldView.backgroundColor = [UIColor blackColor];
                [boardView addSubview:fieldView];
                [self.setOfAllBlackFields addObject:fieldView];
                
                //Создание фигур
                UIView *figure = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(fieldRect) * column,
                                                                         CGRectGetWidth(fieldRect) * string,
                                                                         boardViewProportions / 10,
                                                                         boardViewProportions / 10)];
                figure.layer.cornerRadius = 20.f;
                figure.center = fieldView.center;
                if (string < 3) {
                    figure.backgroundColor = [UIColor whiteColor];
                    [boardView addSubview:figure];
                } else if (string > 4) {
                    figure.backgroundColor = [UIColor redColor];
                    [boardView addSubview:figure];
                }
                [self.setOfAllCheckers addObject:figure];
            } else {
                
                //Создание белых полей.
                UIView *fieldView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(fieldRect) * string,
                                                                             CGRectGetWidth(fieldRect) * column,
                                                                             CGRectGetWidth(fieldRect),
                                                                             CGRectGetWidth(fieldRect))];
                fieldView.backgroundColor = [UIColor whiteColor];
                [boardView addSubview:fieldView];
                [self.setOfAllWhiteFields addObject:fieldView];
            }
        }
    }
}

#pragma mark - Usused methods;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
