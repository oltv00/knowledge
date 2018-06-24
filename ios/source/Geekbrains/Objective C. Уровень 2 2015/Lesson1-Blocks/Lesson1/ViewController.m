//
//  ViewController.m
//  Lesson1
//
//  Created by Oleg Tverdokhleb on 10.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"
#import "ServerManager.h"

typedef void (^BlockedBlock)(void);

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (copy, nonatomic) BlockedBlock myBlock;

@property (strong, nonatomic) NSMutableArray *myArray;

- (IBAction)actionTextField:(UITextField *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *array = [NSMutableArray array];
    //self.array = array;
    for (int i = 0; i < 100000000; i++) {
        [array addObject:@(i)];
    }
    
    void(^blockedBlock)(void) = ^(void){
        NSLog(@"%@", [array objectAtIndex:45]);
    };
    
    self.myBlock = blockedBlock;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"didReceiveMemoryWarning");
}

- (IBAction) actionProcess:(id)sender {
    //[self process:self.myBlock];
    
    [[[ServerManager alloc] init] getImagesWithTag:@"tag"
                                             count:20
                                         onSuccess:^(NSArray *array) {
                                             [self.myArray addObjectsFromArray:array];
                                         }
                                         onFailure:^(NSError *error) {
                                             NSLog(@"%@", [error localizedDescription]);
                                         }];
}

- (void) process:(BlockedBlock) block {
    block();
}

- (void) someBlocks {
    
    void(^block_1)(void) = ^(){
        
    };
    
    void(^block_2)(NSString *) = ^(NSString *string) {
        NSLog(@"%@", string);
    };
    
    NSString *(^block_3)(void) = ^(){
        return [NSString stringWithFormat:@""];
    };
    
    NSString *(^block_4)(NSString *, NSString *);
    block_4 = ^(NSString *string1, NSString *string2) {
        
        return [NSString stringWithFormat:@"%@ %@", string1, string2];
    };
}

- (IBAction)actionTextField:(UITextField *)sender {
    NSLog(@"%@", sender.text);
    
    self.label.alpha = 1;
    
    if ([sender.text rangeOfString:@"bomb"].location == NSNotFound) {
        
        self.label.textColor = [UIColor blackColor];
        self.label.text = @"all is well";
        
    } else {
        
        self.label.textColor = [UIColor redColor];
        self.label.text = @"BOMB!!!";
    }
}








































@end
