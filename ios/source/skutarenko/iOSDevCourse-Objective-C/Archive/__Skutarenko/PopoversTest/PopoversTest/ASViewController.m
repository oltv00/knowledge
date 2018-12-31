//
//  ASViewController.m
//  PopoversTest
//
//  Created by Oleksii Skutarenko on 06.01.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import "ASViewController.h"
#import "ASDetailsViewController.h"

@interface ASViewController () <UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController* popover;

@end

@implementation ASViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void) showControllerAsModal:(UIViewController*)vc {
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav
                       animated:YES
                     completion:^{
                         
                         double delayInSeconds = 3.0;
                         dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                         dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                             
                             [self dismissViewControllerAnimated:YES completion:nil];
                             
                         });
                         
                     }];
    
}

- (void) showController:(UIViewController*) vc inPopoverFromSender:(id) sender {
    
    if (!sender) {
        return;
    }
    
    vc.preferredContentSize = CGSizeMake(300, 300);
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    UIPopoverController* popover = [[UIPopoverController alloc] initWithContentViewController:nav];
    
    popover.delegate = self;
    
    self.popover = popover;
    
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        
        [popover presentPopoverFromBarButtonItem:sender
                        permittedArrowDirections:UIPopoverArrowDirectionAny
                                        animated:YES];
        
    } else if ([sender isKindOfClass:[UIButton class]]) {
        
        [popover presentPopoverFromRect:[(UIButton*)sender frame]
                                 inView:self.view
               permittedArrowDirections:UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight
                               animated:YES];

    }

    
}

- (IBAction) actionAdd:(UIBarButtonItem*)sender {
    
    ASDetailsViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ASDetailsViewController"];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [self showController:vc inPopoverFromSender:sender];
        
    } else {
        
        [self showControllerAsModal:vc];
        
    }
    
    
    
}

- (IBAction) actionPressMe:(UIButton*)sender {
    
    ASDetailsViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ASDetailsViewController"];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [self showController:vc inPopoverFromSender:sender];
        
    } else {
        
        [self showControllerAsModal:vc];
        
    }
    
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    
    self.popover = nil;
    
}

#pragma mark - Segue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"prepareForSegue %@ %@", segue.identifier, NSStringFromClass([segue.destinationViewController class]));
    
    UINavigationController* nav = segue.destinationViewController;
    ASDetailsViewController* vc = [nav.viewControllers firstObject];
    
    vc.bgColor = [UIColor blueColor];
}

@end
