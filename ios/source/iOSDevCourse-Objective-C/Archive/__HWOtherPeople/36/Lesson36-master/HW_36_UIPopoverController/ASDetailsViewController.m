//
//  ASDetailsViewController.m
//  HW_36_UIPopoverController
//
//  Created by MD on 03.07.15.
//  Copyright (c) 2015 hh. All rights reserved.
//

#import "ASDetailsViewController.h"
#import "SCLAlertView.h"



static NSString *kSuccessTitle = @"Отлично";
static NSString *kErrorTitle = @"Ошибка";
static NSString *kNoticeTitle = @"Notice";
static NSString *kWarningTitle = @"Warning";
static NSString *kInfoTitle = @"Info";
static NSString *kSubtitle = @"Запрос отправлен на сервер";
static NSString *kButtonTitle = @"Done";
static NSString *kAttributeTitle = @"Attributed string operation successfully completed.";


@implementation ASDetailsViewController



-(void) loadView {
    
    [super loadView];
    
    for (id obj in [[self view] subviews]) {
        
        NSLog(@"- %@ ",[obj class]);
        if ([obj isKindOfClass:[UILabel class]]) {
            ((UILabel*)obj).clipsToBounds = YES;
            ((UILabel*)obj).layer.cornerRadius = 7;
        }
        
        if ([obj isKindOfClass:[UIButton class]]) {
            ((UIButton*)obj).clipsToBounds = YES;
            ((UIButton*)obj).layer.cornerRadius = 12;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
   
    UIBarButtonItem* backButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    

    self.labelName.text      = [[NSString alloc] initWithFormat:@"Name : %@",self.dataName];
    self.labelFamaly.text    = [[NSString alloc] initWithFormat:@"Famaly : %@",self.dataFamaly];
    self.labelGender.text    = [[NSString alloc] initWithFormat:@"Gender : %@",self.dataGender];
    self.labelDate.text      = [[NSString alloc] initWithFormat:@"Date of Birth : %@",self.dataDateBirth];

    self.labelEducation.text = [[NSString alloc] initWithFormat:@"Education : %@",self.dataEducation];
 
    
    self.dataСhecking = @[self.dataName,self.dataFamaly,self.dataGender,self.dataDateBirth,self.dataEducation];
    
}

-(void) backAction:(id)sender
{
     [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sendToServer:(UIButton *)sender {
   
    int countChecking = 0;
    
    for (NSString* str in self.dataСhecking) {
        
        if ([str length] == 0) {
            countChecking++;
        }
    }
    
    
    if (countChecking > 0) {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert showError:kErrorTitle subTitle:@"Данные заполнены некорректно" closeButtonTitle:kButtonTitle duration:0.f];
    } else {
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        alert.soundURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/right_answer.mp3", [[NSBundle mainBundle] resourcePath]]];
        [alert showSuccess:kSuccessTitle subTitle:kSubtitle closeButtonTitle:kButtonTitle duration:0.0f];
        
    }

}
@end
