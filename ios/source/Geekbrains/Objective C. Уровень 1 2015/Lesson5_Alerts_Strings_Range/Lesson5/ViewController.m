//
//  ViewController.m
//  Lesson5
//
//  Created by Oleg Tverdokhleb on 06.02.16.
//  Copyright © 2016 Oleg Tverdokhleb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *data;

@end

@implementation ViewController

#pragma mark - VCLifeCycles

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self addNotification];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.data = [NSMutableArray array];
    
    [self first];
    [self second];
    [self third];
    [self four];
    [self five];
    [self six];
    [self seven];
    [self eight];
    [self nine];
    [self ten];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary *dict = [self.data objectAtIndex:indexPath.row];

    cell.textLabel.text = [dict objectForKey:@"city"];
    cell.detailTextLabel.text = [dict objectForKey:@"country"];
    
    return cell;
}

#pragma mark - Additional methods

- (void)ten {

    NSArray *keys = [NSArray arrayWithObjects:@"city", @"country", nil];
    
    NSArray *objectsRussia = [NSArray arrayWithObjects:@"Moscow", @"Russia", nil];
    NSArray *objectsUSA = [NSArray arrayWithObjects:@"San-Hose", @"CA", nil];
    NSArray *objectsOther = [NSArray arrayWithObjects:@"otherCity", @"OtherCountry", nil];
    
    NSDictionary *dictRussia = [NSDictionary dictionaryWithObjects:objectsRussia forKeys:keys];
    NSDictionary *dictUSA = [NSDictionary dictionaryWithObjects:objectsUSA forKeys:keys];
    NSDictionary *dictOther = [NSDictionary dictionaryWithObjects:objectsOther forKeys:keys];
    
    [self.data addObject:dictRussia];
    [self.data addObject:dictUSA];
    [self.data addObject:dictOther];
    
    NSMutableDictionary *mDict = [NSMutableDictionary
                                  dictionaryWithObjects:objectsRussia
                                  forKeys:keys];
    
    [mDict setObject:@"Object" forKey:@"forKey"];
    NSLog(@"%@", mDict);
}

- (void)nine {
    NSLog(@"NINE");
    
    NSString *stringOne = @"ONE";
    NSString *stringTwo = @"TWO";
    NSString *stringThree = @"THREE";
    
    NSArray *firstArray = [NSArray arrayWithObjects:stringOne, stringTwo, stringThree, nil];
    NSLog(@"FIRST ARRAY: %@", firstArray);
    
    NSRange range = NSMakeRange(0, 2);
    NSArray *secondArray = [firstArray subarrayWithRange:range];
    NSLog(@"SECOND ARRAY: %@", secondArray);
    
    if ([firstArray containsObject:@"THREE"]) {
        NSLog(@"CONTAINS");
    }
    
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        NSString *string = [NSString stringWithFormat:@"String %i", i];
        [mArray addObject:string];
    }
    [mArray insertObject:@"insert object" atIndex:3];
    
    NSSortDescriptor *desc = [NSSortDescriptor sortDescriptorWithKey:nil
                                                           ascending:YES];
    [mArray sortUsingDescriptors:@[desc]];
    NSLog(@"%@", mArray);
    
    NSLog(@"---------------------");
}

- (void)eight {
    NSLog(@"EIGHT");
    
    NSMutableString *mString = [[NSMutableString alloc] init];
    [mString setString:@"This is mutable string"];
    [mString appendString:@" and added string"];
    NSLog(@"%@", mString);
    
    NSRange range = NSMakeRange(0, 0);
    [mString replaceCharactersInRange:range withString:@"REPLACED TEXT"];
    
    NSLog(@"After replace: %@", mString);
    NSLog(@"---------------------");
}

- (void)seven {
    NSLog(@"SEVEN");
    
    NSString *stringOne = @"One";
    NSString *stringTwo = @"One";
    
    if ([stringOne isEqualToString:stringTwo]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Equal!"
                                                                    message:@"The strings is equal"
                                                             preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Default"
                                                                style:UIAlertActionStyleDefault
                                                              handler:nil];

        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                                style:UIAlertActionStyleCancel
                                                              handler:nil];

        
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"Destructive"
                                                                style:UIAlertActionStyleDestructive
                                                              handler:nil];

        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [alert addAction:destructiveAction];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:YES completion:nil];
        });
    }
}

- (void)six {
    NSLog(@"SIX");
    
    CGRect selfFrame = self.view.frame;
    CGRect selfBounds = self.view.bounds;
    
    NSString *frameString = NSStringFromCGRect(selfFrame);
    NSString *boundsString = NSStringFromCGRect(selfBounds);
    
    NSLog(
          @"\n"
          @"frame : %@\n"
          @"bounds: %@",
          frameString, boundsString
    );
    
    NSLog(@"---------------------");
}

- (void)five {
    NSLog(@"FIVE");
    
    NSString *string = @"3.14159265358979323846264338327950288";
    
    int intValue            = [string intValue];
    NSInteger integerValue  = [string integerValue];
    float floatValue        = [string floatValue];
    double doubleValue      = [string doubleValue];
    
    NSLog(
          @"\n"
          @"Int      : %d\n"
          @"NSInteger: %ld\n"
          @"Float    : %f\n"
          @"Double   : %g",
          intValue, integerValue, floatValue, doubleValue
    );

    NSLog(@"---------------------");
}

- (void)four {
    NSLog(@"FOUR");
    
    NSString *string = @"String And Space";
    
    NSArray *array = [string componentsSeparatedByString:@" "];
    NSLog(@"%@", array);
    
    for (NSString *string in array) {
        NSUInteger lenght = [string length];
        NSLog(@"line: %@ have %ld symbols", string, lenght);
    }
    NSLog(@"---------------------");
}

- (void)third {
    NSLog(@"THIRD");
    
    NSString *string = @"This is test string";

    NSRange range = NSMakeRange(0, 4);
    NSString *resultString = [string substringWithRange:range];
    
    NSLog(@"%@", resultString);
    NSLog(@"---------------------");
}

- (void)second {
    NSLog(@"SECOND");
    
    NSString *string = @"String";
    NSString *resultString = [string substringFromIndex:2];
    NSLog(@"%@", resultString);
    NSLog(@"---------------------");
}

- (void)first {
    NSLog(@"FIRST");
    
    NSString *string = @"String";
    NSString *stringTwo = [string stringByAppendingString:@" and some added string"];
    
    NSLog(@"%@", stringTwo);
    NSLog(@"---------------------");
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(six)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
