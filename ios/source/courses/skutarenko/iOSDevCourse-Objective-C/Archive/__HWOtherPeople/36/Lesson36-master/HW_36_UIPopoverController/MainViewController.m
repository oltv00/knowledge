//
//  MainViewController.m
//  HW_36_UIPopoverController
//
//  Created by MD on 03.07.15.
//  Copyright (c) 2015 hh. All rights reserved.
//

#import "MainViewController.h"
#import "ASDetailsViewController.h"
#import "ASEducationPopover.h"
#import "ASDateBirthPopover.h"

#import "ASDataArray.h"
#import "UIColor+ColorFromHex.h"
#import "UIView+FirstResponder.h"

@interface MainViewController () <ASEducationPopoverDelegate,ASDateBirthPopoverDelegate>

@property (strong, nonatomic)        UIPopoverController*   popover;
@property (weak, nonatomic) IBOutlet UITextField*           nameTextField;
@property (weak, nonatomic) IBOutlet UITextField*           famalyTextField;

@property (weak, nonatomic) IBOutlet UISegmentedControl*    segmentGender;

@property (weak, nonatomic) IBOutlet UITextField*           dateTextField;
@property (weak, nonatomic) IBOutlet UITextField*           educationTextField;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldArray;

@property (strong, nonatomic) ASDataArray* data;
@property (strong, nonatomic) UIView* customEducationView;
@property (strong, nonatomic) UIView* customDateBirthView;

@end




@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (![textField isEqual:[self.textFieldArray objectAtIndex:[self.textFieldArray count]-1]]) {
        
        NSInteger index = [self.textFieldArray indexOfObject:textField];
        [[self.textFieldArray objectAtIndex:index+1] becomeFirstResponder];
        
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    
    if ([textField isEqual:self.educationTextField]) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            ASEducationPopover* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ASEducationPopover"];
            vc.delegate = self;

            ASDataArray* data = [[ASDataArray alloc] init];
            vc.dataForArray   = data.educationArray;
            vc.preferredContentSize = CGSizeMake(300, 300);
            
            UIPopoverController* pop = [[UIPopoverController alloc] initWithContentViewController:vc];
            pop.delegate = self;
            self.popover = pop;

            [pop presentPopoverFromRect:textField.frame
                                 inView:self.view
               permittedArrowDirections:UIPopoverArrowDirectionAny
                               animated:YES];
            return NO;
            }
        else {

        self.customEducationView = [self creatEducationCustomView];
        self.customEducationView.alpha = 0.f;
        [self.view addSubview:self.customEducationView];
        [self.customEducationView canBecomeFirstResponder];
        [self.customEducationView becomeFirstResponder];
       
        [UIView animateKeyframesWithDuration:0.3f
                                       delay:0
                                     options:UIViewAnimationOptionCurveEaseIn animations:^{
                                         [self.customEducationView setAlpha:1.f];
                                     } completion:nil];
         return NO;
        }
    }
    
    
    if ([textField isEqual:self.dateTextField]) {
        
     
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            ASEducationPopover* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ASDateBirthPopover"];
            vc.delegate = self;
           
            vc.preferredContentSize = CGSizeMake(300, 300);
            
            UIPopoverController* pop = [[UIPopoverController alloc] initWithContentViewController:vc];
            pop.delegate = self;
            self.popover = pop;
            
            [pop presentPopoverFromRect:textField.frame
                                 inView:self.view
               permittedArrowDirections:UIPopoverArrowDirectionAny
                               animated:YES];
            return NO;
        } else {
            
            self.customDateBirthView = [self creatDateBirthCustomView];
            self.customDateBirthView.alpha = 0.f;
            [self.view addSubview:self.customDateBirthView];
            [self.customEducationView canBecomeFirstResponder];
            [self.customDateBirthView becomeFirstResponder];
           
            [UIView animateKeyframesWithDuration:0.3f
                                           delay:0
                                         options:UIViewAnimationOptionCurveEaseIn animations:^{
                                             [self.customDateBirthView setAlpha:1.f];
                                         } completion:nil];
            return NO;
         }

        
        
    }

    
    return YES;
}

#pragma mark - UIPickerViewDelegate


- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.data.educationArray) {
        return [self.data.educationArray count];
    }
    
    return 0;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   
    if (self.data.educationArray) {
        return [self.data.educationArray objectAtIndex:row];
    }
    
    return @"Default";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
   
    self.educationTextField.text = [self.data.educationArray objectAtIndex:row];
}


#pragma mark - Helper Method

-(void) showControllerAsModal:(UIViewController*) vc {
    
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav
                       animated:YES
                     completion:nil];
}



#pragma mark - Creat Custom View For iPhone


-(UIView*) creatEducationCustomView {
    
    
    CGFloat x = CGRectGetWidth(self.view.bounds)/8/2;
    CGFloat y = (self.view.center.y)/2;
    
    CGFloat width  = CGRectGetWidth(self.view.bounds) - x*2;
    CGFloat height = CGRectGetHeight(self.view.bounds)/2;
    
    
    UIView* viewForEducation = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];

    UIColor* color = [UIColor colorWithRed:0.973 green:0.894 blue:0.412 alpha:1];
    [viewForEducation setBackgroundColor:color];
    [viewForEducation setClipsToBounds:YES];
    [viewForEducation.layer setCornerRadius:12];
    [viewForEducation setCenter:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))];
    
    /*
    x      = CGRectGetWidth(viewForEducation.bounds)/8/2;
    height = CGRectGetHeight(viewForEducation.bounds)/4.6;
    y      = CGRectGetMaxY(viewForEducation.bounds) - height-10;
    width  = CGRectGetWidth(viewForEducation.bounds) - x*2;
    
    
    
    UIButton *button = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    button.frame = CGRectMake(x, y, width, height);
    [button setBackgroundColor:[UIColor colorWithRed:0.439 green:0.922 blue:0.42 alpha:1]];
    [button setTitle:@"Done" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(DoneButtonEducationCustomView:) forControlEvents:UIControlEventTouchUpInside];
    */
    
    // Reuse varable
    x = CGRectGetWidth(viewForEducation.bounds)/8/2;
    y = CGRectGetMinY(viewForEducation.bounds)+20;
    width  = CGRectGetWidth(viewForEducation.bounds) - x*2;
    height  = CGRectGetMaxY(viewForEducation.bounds) - 5;
    
    
    UIPickerView* educationPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    
    educationPickerView.alpha = 1.f;
    educationPickerView.dataSource = self;
    educationPickerView.delegate   = self;
   
    ASDataArray* tmpData = [[ASDataArray alloc] init];
    self.data = tmpData;
    
    //[viewForEducation addSubview:button];
    [viewForEducation addSubview:educationPickerView];

    return viewForEducation;
}


-(UIView*) creatDateBirthCustomView {
    
    CGFloat x = CGRectGetWidth(self.view.bounds)/8/2;
    CGFloat y = (self.view.center.y)/2;
    
    CGFloat width  = CGRectGetWidth(self.view.bounds) - x*2;
    CGFloat height = CGRectGetHeight(self.view.bounds)/2;
    
    
    UIView* viewForDateBirth = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    
    UIColor* color = [UIColor colorWithRed:0.973 green:0.894 blue:0.412 alpha:1];
    [viewForDateBirth setBackgroundColor:color];
    [viewForDateBirth setClipsToBounds:YES];
    [viewForDateBirth.layer setCornerRadius:12];
    [viewForDateBirth setCenter:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))];
    
    // Reuse varable
    x = CGRectGetMinX(viewForDateBirth.bounds) - CGRectGetWidth(viewForDateBirth.bounds)/8/2;
    y = CGRectGetMinY(viewForDateBirth.bounds) + CGRectGetHeight(viewForDateBirth.bounds)/8/2;
    width  = CGRectGetWidth(viewForDateBirth.bounds) ;
    height  = CGRectGetMaxY(viewForDateBirth.bounds) ;
    
    
    ///////
    NSLocale *usLocale = [[NSLocale alloc]
                          initWithLocaleIdentifier:@"ru_RUS"];
    
    UIDatePicker* datePickerView  = [[UIDatePicker alloc] initWithFrame:CGRectMake(x, y, width, height)];
    datePickerView.datePickerMode = UIDatePickerModeDate;
    datePickerView.locale = usLocale;
    //datePickerView.center = viewForDateBirth.center;
    [datePickerView addTarget:self action:@selector(birthDateChanged:) forControlEvents:UIControlEventValueChanged];

    [viewForDateBirth addSubview:datePickerView];
    return viewForDateBirth;
}




#pragma mark - Selectors method for custom views



-(void) DoneButtonEducationCustomView:(id)sender {
    
   /*
   UIPickerView* tmpPicker;
    
    for (id obj in [[self customEducationView] subviews]) {
        if ([obj isKindOfClass:[UIPickerView class]]) {
            tmpPicker = obj;
        }
    }
    
    NSInteger row = [tmpPicker selectedRowInComponent:0];
    self.educationTextField.text = [self.data.educationArray objectAtIndex:row];
    */
    /*
   [UIView animateWithDuration:0.7f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
       [self.customEducationView setAlpha:0.f];
   } completion:^(BOOL finished) {
   
       [self.customEducationView resignFirstResponder];
    
       // Удаляем из памяти
       [self.customEducationView removeFromSuperview];
       self.customEducationView = nil;
       self.data = nil;
   
   }];*/

}


- (IBAction)birthDateChanged:(UIDatePicker *)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    NSString *formatedDate = [dateFormatter stringFromDate:sender.date];
    
    self.dateTextField.text = formatedDate;
}


#pragma mark - Move to ASDetailsViewController


- (IBAction)infoBarButtonItem:(UIBarButtonItem *)sender {
    
    
    ASDetailsViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ASDetailsViewController"];
    
    vc.dataName   = self.nameTextField.text;
    vc.dataFamaly = self.famalyTextField.text;
    vc.dataEducation = self.educationTextField.text;
    vc.dataDateBirth = self.dateTextField.text;
    vc.dataGender = [self.segmentGender titleForSegmentAtIndex:self.segmentGender.selectedSegmentIndex];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        vc.preferredContentSize = CGSizeMake(300, 300);
        
        UIPopoverController* pop = [[UIPopoverController alloc] initWithContentViewController:vc];
        
        
        pop.delegate = self;
        self.popover = pop;
        
        [pop presentPopoverFromBarButtonItem:sender
                    permittedArrowDirections:UIPopoverArrowDirectionAny
                                    animated:YES];
    }
    else {
        [self showControllerAsModal:vc];
    }
    
    
}

#pragma mark - Pass Data


- (void)dataFromEducationController:(NSString *)data
{
    self.educationTextField.text = data;
}


- (void)dataFromDateBirthController:(NSString *)data {
    
    self.dateTextField.text = data;
}



-(void) hideKeyBoard {
    
    for (UITextField* field in self.textFieldArray) {
        
        if ([field isFirstResponder]) {
            [field resignFirstResponder];
        }
    }
}


-(void) handleTap:(UITapGestureRecognizer*) tap {
    
    
    
    if ([self.customEducationView isFirstResponder]) {
       
        [UIView animateWithDuration:0.7f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [self.customEducationView setAlpha:0.f];
        } completion:^(BOOL finished) {
            
            [self.customEducationView resignFirstResponder];
            
            // Удаляем из памяти
            [self.customEducationView removeFromSuperview];
            self.customEducationView = nil;
            self.data = nil;
        }];
        
    } else
        if ([self.customDateBirthView isFirstResponder]) {
            
            [UIView animateWithDuration:0.7f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                [self.customDateBirthView setAlpha:0.f];
            } completion:^(BOOL finished) {
                
                [self.customDateBirthView resignFirstResponder];
                
                // Удаляем из памяти
                [self.customDateBirthView removeFromSuperview];
                self.customDateBirthView = nil;
            }];
            
        }
        else {
            [self hideKeyBoard];

        }
    
}




@end
