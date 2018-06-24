//
//  ViewController.m
//  Lesson3HW
//
//  Created by Oleg Tverdokhleb on 20.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#define constChessSize 40

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) UIView *viewBoard;

@end

@implementation ViewController

#pragma mark - VCLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self setupBoard];
    [self setupCells];
    [self setupFigures];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupBoard {
    CGFloat boardWidth = constChessSize * 8;
    CGFloat boardHeight = constChessSize * 8;
    CGRect rectBoard = CGRectMake(0, 0, boardWidth, boardHeight);
    UIView *viewBoard = [[UIView alloc] initWithFrame:rectBoard];

    viewBoard.backgroundColor = [UIColor blackColor];
    viewBoard.layer.borderWidth = 2.f;
    viewBoard.center = self.view.center;

    [self.view addSubview:viewBoard];
    _viewBoard = viewBoard;
}

- (void)setupCells {
    for (int string = 0; string < 8; string++) {
        for (int column = 0; column < 8; column++) {
            if ((string % 2 == 0 && column % 2 != 0) || (string % 2 != 0 && column % 2 == 0)) {
                
                NSLog(@"white {%d:%d}", string, column);
                
                CGRect rect = CGRectMake(constChessSize * column,
                                         constChessSize * string,
                                         constChessSize,
                                         constChessSize);
                
                UIView *view = [[UIView alloc] initWithFrame:rect];
                view.backgroundColor = [UIColor whiteColor];
                
                [_viewBoard addSubview:view];
                
            } else {
                
                NSLog(@"black {%d:%d}", string, column);
                
                CGRect rect = CGRectMake(constChessSize * string,
                                         constChessSize * column,
                                         constChessSize,
                                         constChessSize);
                
                UIView *view = [[UIView alloc] initWithFrame:rect];
                view.backgroundColor = [UIColor blackColor];
                
                [_viewBoard addSubview:view];
            }
        }
    }
}

- (void)setupFigures {
    for (int string = 0; string < 8; string++) {
        for (int column = 0; column < 8; column++) {
            UIView *figure = [[UIView alloc] initWithFrame:CGRectMake(constChessSize * column,
                                                                      constChessSize * string,
                                                                      constChessSize,
                                                                      constChessSize)];
            figure.layer.cornerRadius = CGRectGetWidth(figure.frame) / 2;
            
            if (string < 2) {

                figure.backgroundColor = [UIColor redColor];
            
            } else
                if (string > 5) {
                    figure.backgroundColor = [UIColor blueColor];
                }
            [_viewBoard addSubview:figure];
        }
    }
}

- (void)addImagesToFigures {
    NSMutableArray *images = [NSMutableArray array];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSBundle *bundle = [NSBundle mainBundle];
    NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:[bundle bundlePath]];
    for (NSString *name in enumerator) {
        if ([name hasSuffix:@".jpg"]) {
            UIImage *image = [UIImage imageNamed:name];
            [images addObject:image];
        }
    }
    for (int i = 0; i < [images count]; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100,
                                                                100,
                                                                100,
                                                                100)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.bounds];
        imageView.image = [images objectAtIndex:i];
        [view addSubview:imageView];
        [self.view addSubview:view];
    }
}

@end





























