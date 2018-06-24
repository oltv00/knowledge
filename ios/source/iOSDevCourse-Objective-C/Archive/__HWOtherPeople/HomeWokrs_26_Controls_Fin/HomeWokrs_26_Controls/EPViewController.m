//
//  EPViewController.m
//  HomeWokrs_26_Controls
//
//  Created by Admin on 27.04.15.
//  Copyright (c) 2015 Evgenii Penkrat. All rights reserved.
//

#import "EPViewController.h"

#import "EPSwitch.h"
#import "EPSlider.h"


static NSString* const KeyTypeAnimation = @"KeyTypeAnimation";

static NSString* const AnimationKeyScaleSanta       = @"AnimationKeyScaleSanta";
static NSString* const AnimationKeyRotationSanta    = @"AnimationKeyRotationSanta";
static NSString* const AnimationKeyTranslationSanta = @"AnimationKeyTranslationSanta";




typedef NS_ENUM(NSUInteger, AnimationType) {
    AnimationTypeNone               = 0,
    AnimationTypeScaleSanta         = 1,
    AnimationTypeRotationSanta      = 2,
    AnimationTypeTranslationSanta   = 3
};


@interface EPViewController ()

@property (strong,nonatomic) NSMutableArray* arrSwitchsForSanta;
@property (strong, nonatomic) UIImageView* imageSanta;

@property (assign, nonatomic) CGFloat durationAnemation;

@property (assign, nonatomic) BOOL statusTranslationSanta;
@property (assign, nonatomic) CGFloat targetAnimXPositionSanta;
@property (assign, nonatomic) CGFloat endXPositionSanta;

@property (assign, nonatomic) BOOL statusScaleSanta;
@property (assign, nonatomic) CGFloat targetAnimScaleSanta;
@property (assign, nonatomic) CGFloat endScaleSanta;

@property (assign, nonatomic) BOOL statusRotationSanta;
@property (assign, nonatomic) CGFloat targetAnimRotatSanta;
@property (assign, nonatomic) CGFloat endRotatSanta;

@end

@implementation EPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageSanta = [[UIImageView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    [self.view addSubview:self.imageSanta];
    [self setImageByIndex:0];
    
   
    self.durationAnemation = 1;
    
    self.arrSwitchsForSanta = [NSMutableArray new];
    
    NSArray* idsSwitchs = @[[NSNumber numberWithInteger:EPSwitchIdRotation],
                            [NSNumber numberWithInteger:EPSwitchIdScale],
                            [NSNumber numberWithInteger:EPSwitchIdTranslation]];
    NSUInteger countSwitch = 0;
    
    for (NSNumber* numberSwitchId in idsSwitchs) {
        
        EPSwitchId switchId = [numberSwitchId unsignedIntegerValue];
        
        EPSwitch* switchForSanta = [[EPSwitch alloc] initWithFrame:CGRectMake(50 + countSwitch*70, 30, 10, 10)
                                                                id:switchId
                                                        andIdGruop:EPSwitchIdGroupSanta];
        
        [self.view addSubview:switchForSanta];
        [self.arrSwitchsForSanta addObject:switchForSanta];
        [switchForSanta addTarget:self action:@selector(handleSwitch:) forControlEvents:UIControlEventValueChanged];
        
        countSwitch++;
    }
    
    
    
    EPSlider* sliderSpeed = [[EPSlider alloc] initWithFrame:CGRectMake(50, 100, 200, 10)
                                                         id:EPSliderIdSpeed
                                                 andIdGruop:EPSSliderIdGroupSanta];
    [self.view addSubview:sliderSpeed];
    sliderSpeed.minimumValue = 0.5f;
    sliderSpeed.maximumValue = 2.f;
    [sliderSpeed setValue:1.f];
    [sliderSpeed addTarget:self action:@selector(handleSlider:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UISegmentedControl* segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"1", @"2", @"3"]];
    [self.view addSubview:segmentedControl];
    segmentedControl.frame = CGRectMake(50, 150, 100, 20);
    [segmentedControl addTarget:self action:@selector(handleSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;
    
}








#pragma marc - Events



-(void) handleSegmentedControl:(UISegmentedControl*) segmentedControl{
    [self setImageByIndex:segmentedControl.selectedSegmentIndex];
}








-(void) handleSlider:(EPSlider*) slider{
    
    self.durationAnemation = slider.value;
    
    if(self.statusTranslationSanta){
        [self translationSantawithLoop:NO];
    }
    
    if(self.statusScaleSanta){
        [self scaleSanta];
    }
    
    if(self.statusRotationSanta){
       [self rotationSanta];
    }
    
    
}




-(void) handleSwitch:(EPSwitch*)_switch{
    switch (_switch.idGruop) {
        case EPSwitchIdGroupSanta:
            
            //ОДНОВРЕМЕНННО
            
            switch (_switch.id) {
                    
                case EPSwitchIdRotation:
                    
                    if([_switch isOn]){
                        self.statusRotationSanta = YES;
                        [self rotationSanta];
                    }else{
                        self.statusRotationSanta = NO;
                        CGFloat currentRotat = [self getCurrentAngleRotationView:self.imageSanta];
                        self.endRotatSanta = currentRotat;
                        [self.imageSanta.layer removeAnimationForKey:AnimationKeyRotationSanta];
                        [self updateTranspormView:self.imageSanta];
                    }
                    break;
                    
                    
                case EPSwitchIdScale:
                    
                    if([_switch isOn]){
                        self.statusScaleSanta = YES;
                        [self scaleSanta];
                    }else{
                        self.statusScaleSanta = NO;
                        CGFloat currentScale = [self getCurrentScaleXView:self.imageSanta];
                        self.endScaleSanta = currentScale;
                        [self.imageSanta.layer removeAnimationForKey:AnimationKeyScaleSanta];
                        [self updateTranspormView:self.imageSanta];
                    }
                    break;
                    
                    
                case EPSwitchIdTranslation:
                    
                    if([_switch isOn]){
                        self.statusTranslationSanta = YES;
                        [self translationSantawithLoop:NO];
                    }else{
                        self.statusTranslationSanta = NO;
                        CGPoint currentPozitionSanta = [self getCurrentPositionView:self.imageSanta];
                        self.endXPositionSanta = currentPozitionSanta.x;
                        [self.imageSanta.layer removeAnimationForKey:AnimationKeyTranslationSanta];
                        [self updateTranspormView:self.imageSanta];
                    }
                    break;
            }
            
            break;

    }
    
}







#pragma marc - Simple Methods



-(void) setImageByIndex:(NSUInteger)index{
    self.imageSanta.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", (index+1)]];
}


-(EPSwitch*) returnSwitchFromArray:(NSMutableArray*) arr byId:(EPSwitchId) id andIdGroup:(EPSwitchIdGroup) idGroup{
    for (EPSwitch* _switch in arr) {
        if(_switch.idGruop == idGroup   &&  _switch.id == id){
            return _switch;
        }
    }
    return NULL;
}


// Определяет координаты вьюхи при прерывании анимации перемещения
-(CGPoint) getCurrentPositionView:(UIView*) view{
    CGRect frameImageSanta = [[view.layer presentationLayer] frame];
    return CGPointMake(CGRectGetMidX(frameImageSanta), CGRectGetMidY(frameImageSanta));
    
}

// Определяет угол поворота вьюхи при прерывании анимации вращения
-(CGFloat) getCurrentAngleRotationView:(UIView*) view{
    CGFloat angleRadian = [[[view.layer presentationLayer] valueForKeyPath:@"transform.rotation.z"] floatValue];//
    return angleRadian;
}


// Определяет величину масштабирования вьюхи при прерывании анимации масштабирования
-(CGFloat) getCurrentScaleXView:(UIView*) view{
    return [[[view.layer presentationLayer] valueForKeyPath:@"transform.scale.x"] floatValue];
}



// Пре образование значения угла повотоа в диапазон 0-2PI. Так как система значения поворотов большие PI конвертит в отрицательные значения.
-(CGFloat) convertAngleTo2PI:(CGFloat) angle{    if(angle < 0) return 2*M_PI + angle;
    return angle;
}






#pragma marc - Animation Methods


-(void) rotationSanta{
    
    CGFloat const angle = 2*M_PI/5;
    
    CGFloat const angleCurrent2PIRad = [self convertAngleTo2PI:[self getCurrentAngleRotationView:self.imageSanta]];
    
    self.targetAnimRotatSanta = angleCurrent2PIRad+angle;
    self.endRotatSanta = self.targetAnimRotatSanta;
    
    CABasicAnimation * anemRotat = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anemRotat.duration = 0.5 * angle / self.durationAnemation;;
    anemRotat.fromValue = [NSNumber numberWithFloat:angleCurrent2PIRad];
    anemRotat.toValue = [NSNumber numberWithFloat:(self.targetAnimRotatSanta)];
    anemRotat.delegate = self;
    [anemRotat setValue:[NSNumber numberWithUnsignedInteger:AnimationTypeRotationSanta] forKey:KeyTypeAnimation];
    [self.imageSanta.layer addAnimation:anemRotat forKey:AnimationKeyRotationSanta];
    
    // Важно !! Что бы после оконьчания анимации объект не принимал первоначальное значение масштаба:
    [self updateTranspormView:self.imageSanta];
    
    
}









-(void) scaleSanta{
    
    CGFloat const maxScale = 2;
    CGFloat const minScale = 0.5;
    
    CGFloat currentScale = [self getCurrentScaleXView:self.imageSanta];
    
    if(!self.targetAnimScaleSanta){
        self.targetAnimScaleSanta = minScale;
    }
    
    if(currentScale >= maxScale){
        self.targetAnimScaleSanta = minScale;
    }else if(currentScale <= minScale){
        self.targetAnimScaleSanta = maxScale;
    }
    
    self.endScaleSanta = self.targetAnimScaleSanta;
    
    CGFloat const duration = 1 * (abs(self.targetAnimScaleSanta*10000 - currentScale*10000)/10000.f) / self.durationAnemation;
   
    CABasicAnimation * anemScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anemScale.duration = duration;
    anemScale.fromValue = [NSNumber numberWithFloat:currentScale];
    anemScale.toValue = [NSNumber numberWithFloat:self.targetAnimScaleSanta];
    anemScale.delegate = self;
    [anemScale setValue:[NSNumber numberWithUnsignedInteger:AnimationTypeScaleSanta] forKey:KeyTypeAnimation];
    [self.imageSanta.layer addAnimation:anemScale forKey:AnimationKeyScaleSanta];
    
    // Важно !! Что бы после оконьчания анимации объект не принимал первоначальное значение масштаба:
    [self updateTranspormView:self.imageSanta];

}





-(void) translationSantawithLoop:(BOOL) loop{
    
    if(!self.targetAnimXPositionSanta || loop){
        self.targetAnimXPositionSanta = self.imageSanta.center.x > self.view.frame.size.width/2 ? 30 : 270;
    }
    
    CGPoint currentPozitionSanta = [self getCurrentPositionView:self.imageSanta];
    
    CGPoint const targetPointAnimPositionSanta = CGPointMake(self.targetAnimXPositionSanta, currentPozitionSanta.y);
    
    CGFloat const duration = 0.01 * abs(self.targetAnimXPositionSanta-currentPozitionSanta.x) / self.durationAnemation;
    
    self.endXPositionSanta = self.targetAnimXPositionSanta;
    
    CABasicAnimation* animTranslation = [CABasicAnimation animationWithKeyPath:@"position"];
    animTranslation.duration = duration;
    animTranslation.fromValue = [NSValue valueWithCGPoint:currentPozitionSanta];
    animTranslation.toValue = [NSValue valueWithCGPoint:targetPointAnimPositionSanta];
    animTranslation.delegate = self;
    [animTranslation setValue:[NSNumber numberWithUnsignedInteger:AnimationTypeTranslationSanta] forKeyPath:KeyTypeAnimation];
    [self.imageSanta.layer addAnimation:animTranslation forKey:AnimationKeyTranslationSanta];
    
    // Важно !! Что бы после оконьчания анимации объект не принимал первоначальное значение позиции:
    [self updateTranspormView:self.imageSanta];
    
}






- (void) updateTranspormView:(UIView*) view{

    
    if(!self.endScaleSanta){
        self.endScaleSanta = 1;
    }
    
    if(!self.endRotatSanta){
        self.endRotatSanta = 0;
    }

    CGAffineTransform transforScale = CGAffineTransformMakeScale(self.endScaleSanta, self.endScaleSanta);
    CGAffineTransform transforRotat= CGAffineTransformMakeRotation(self.endRotatSanta);
    view.transform = CGAffineTransformConcat(transforScale, transforRotat);
    
    CGPoint currentPozitionSanta = [self getCurrentPositionView:self.imageSanta];
    
    if(!self.endXPositionSanta){
        self.endXPositionSanta = currentPozitionSanta.x;
    }

    view.center = CGPointMake(self.endXPositionSanta, currentPozitionSanta.y);
    
}





- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
    
    CABasicAnimation * anem = (CABasicAnimation*)theAnimation;
    
    if(flag && anem){
        
        NSNumber* value = [theAnimation valueForKey:KeyTypeAnimation];
        
        NSInteger valueInt  =   [value unsignedIntegerValue];
        
        switch (valueInt) {
            case AnimationTypeScaleSanta:
                [self scaleSanta];
                break;
                
            case AnimationTypeRotationSanta:
                [self rotationSanta];
                break;
                
                
            case AnimationTypeTranslationSanta:
                [self translationSantawithLoop:YES];
                break;
        }
        
       
    }
    
    
}





@end
