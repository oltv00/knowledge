//
//  SMRMainViewController.m
//  Test-centr-delovih-innovacii
//
//  Created by Oleg Tverdokhleb on 12/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//


#import "SMRMainViewController.h"

//Categories
#import "Utils.h"

//API
#import "APIManager.h"

//Model
#import "SMRUser.h"

//UI
#import "SMRLoginViewController.h"

//Core
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

typedef NS_ENUM(NSInteger, SMRVideoSourceType) {
  SMRVideoSourceTypeCamera,
  SMRVideoSourceTypeSavedPhotosAlbum
};

@interface SMRMainViewController () <SMRLoginViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//IBOutlets
@property (weak, nonatomic) IBOutlet UILabel *user_idLabel;
@property (weak, nonatomic) IBOutlet UIView *leftCaptureView;
@property (weak, nonatomic) IBOutlet UIView *rightCaptureView;

//internal properties
@property (strong, nonatomic) SMRUser *user;
@property (strong, nonatomic) NSURL *mergedVideoURL;
@property (strong, nonatomic) NSMutableArray <AVAsset *> *assets;
@property (assign, nonatomic) SMRVideoSourceType sourceType;
@property (assign, nonatomic) BOOL isLeftLabelLoading;

@end

@implementation SMRMainViewController

#pragma mark - View life cycles

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.assets = [NSMutableArray array];
  self.isLeftLabelLoading = NO;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateUserInfo];
  [self updateUI];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if (![self isUserLoggedIn]) {
    [self callLoginVC];
  }
}

- (void)updateUI {
  self.user_idLabel.text = [NSString stringWithFormat:@"User ID: %@", self.user.user_id];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Helper method

- (BOOL)isUserLoggedIn {
  if (self.user && [self isExpiresIn]) {
    return YES;
  }
  return NO;
}

- (BOOL)isExpiresIn {
  NSDate *now = [NSDate date];
  NSDate *expires_in = [[NSUserDefaults standardUserDefaults] objectForKey:@"expires_in"];
  NSLog(@"NOW = %@ | expires_in = %@", now, expires_in);
  if ([now compare:expires_in] == NSOrderedAscending) {
    return YES;
  }
  return NO;
}

- (void)updateUserInfo {
  NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:@"SMRUser"];
  self.user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
}

- (void)pickVideoWithSourceType:(UIImagePickerControllerSourceType )sourceType {
  
  UIImagePickerController *picker = [[UIImagePickerController alloc] init];
  picker.delegate = self;
  picker.mediaTypes = @[(NSString *)kUTTypeMovie];
  picker.allowsEditing = YES;
  
  if (sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
      picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
  } else if (sourceType == UIImagePickerControllerSourceTypeCamera) {
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
      picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
  }
  
  [self presentViewController:picker animated:YES completion:nil];
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(id)info {
  NSString *title = nil;
  NSString *msg = nil;
  
  if (error) {
    title = @"Ошибка";
    msg = @"Не удается сохранить видео";
  } else {
    title = @"Видео успешно сохранено";
    msg = @"";
  }
  
  [UIAlertController showAlert:title message:msg inVC:self];
}

- (void)addPlayer:(AVPlayer *)player toView:(UIView *)view {
  [self loopVideo:player];
  AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
  [view.layer addSublayer:playerLayer];
  playerLayer.frame = view.bounds;
  [player play];
}

- (void)updateViewsWithPlayer:(AVPlayer *)player {
  if (self.isLeftLabelLoading) {
    [self addPlayer:player toView:self.rightCaptureView];
    self.isLeftLabelLoading = NO;
  } else {
    [self addPlayer:player toView:self.leftCaptureView];
    self.isLeftLabelLoading = YES;
  }
}

- (void)loopVideo:(AVPlayer *)videoPlayer {
  [[NSNotificationCenter defaultCenter] addObserverForName:AVPlayerItemDidPlayToEndTimeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
    [videoPlayer seekToTime:kCMTimeZero];
    [videoPlayer play];
  }];
}

#pragma mark - Navigation

- (void)callLoginVC {
  SMRLoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMRLoginViewController"];
  loginVC.delegate = self;
  [self presentViewController:loginVC animated:YES completion:nil];
}

#pragma mark - Action

- (IBAction)actionLogout:(UIButton *)sender {
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SMRUser"];
  [self callLoginVC];
}

- (IBAction)actionMerge:(UIButton *)sender {
  
  [self mergeWithAssets:self.assets];
}

- (IBAction)actionAddVideo:(UIButton *)sender {
  self.sourceType = SMRVideoSourceTypeSavedPhotosAlbum;
  [self pickVideoWithSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
}

- (IBAction)actionCapture:(UIButton *)sender {
  self.sourceType = SMRVideoSourceTypeCamera;
  [self pickVideoWithSourceType:UIImagePickerControllerSourceTypeCamera];
}

- (IBAction)actionUpload:(UIButton *)sender {
  
  if (self.assets.count < 2) {
    [UIAlertController showAlert:@"Ошибка" message:@"Нужно выбрать два видео" inVC:self];
    return;
  }
  
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Введите имя файла" message:nil preferredStyle:UIAlertControllerStyleAlert];
  [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    textField.placeholder = @"Имя файла";
    textField.textColor = [UIColor blueColor];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.borderStyle = UITextBorderStyleRoundedRect;
  }];
  
  UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    NSArray *textfields = alert.textFields;
    UITextField *fileNameTextField = textfields[0];
    NSString *fileName = fileNameTextField.text;
    if ([fileName isEqualToString:@""]) {
      [UIAlertController showAlert:@"Необходимо ввести имя файла" message:nil inVC:self];
      return;
    }
    [[APIManager shared] uploadVideoWithName:fileName video:self.mergedVideoURL compeltion:^(APIManagerServerResponse status) {
      switch (status) {
        case APIManagerServerResponseSuccess: {
          [UIAlertController showAlert:@"Видео успешно загружено на сервер" message:nil inVC:self];
          break;
        }
          
        case APIManagerServerResponseFailure: {
          [UIAlertController showAlert:@"Ошибка при загрузке видео" message:nil inVC:self];
          break;
        }
          
        default: break;
      }
    }];
  }];
  
  UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
  
  [alert addAction:ok];
  [alert addAction:cancel];
  [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Merge Video

- (void)mergeWithAssets:(NSArray <AVAsset *> *)assets {
  
  if (assets.count < 2) {
    [UIAlertController showAlert:@"Ошибка" message:@"Нужно выбрать два видео" inVC:self];
    return;
  }
  
  AVMutableComposition *mixComposition = [AVMutableComposition new];
  AVMutableCompositionTrack *track1 = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
  
  NSError *error = nil;
  [track1 insertTimeRange:CMTimeRangeMake(kCMTimeZero, assets[0].duration) ofTrack:[assets[0] tracksWithMediaType:AVMediaTypeVideo][0] atTime:kCMTimeZero error:&error];
  if (error) {
    [UIAlertController showAlert:@"Ошибка" message:nil inVC:self];
  }
  
  AVMutableCompositionTrack *track2 = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
  
  [track2 insertTimeRange:CMTimeRangeMake(kCMTimeZero, assets[1].duration) ofTrack:[assets[1] tracksWithMediaType:AVMediaTypeVideo][0] atTime:assets[0].duration error:&error];
  if (error) {
    [UIAlertController showAlert:@"Ошибка" message:nil inVC:self];
  }
  
  AVMutableVideoCompositionInstruction *mainInstruction = [AVMutableVideoCompositionInstruction new];
  mainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, CMTimeAdd(assets[0].duration, assets[1].duration));
  
  AVMutableVideoCompositionLayerInstruction *firstInstruction = [self videoCompositionInstructionForTrack:track1 asset:assets[0]];
  [firstInstruction setOpacity:0.0 atTime:assets[0].duration];
  AVMutableVideoCompositionLayerInstruction *secondInstruction = [self videoCompositionInstructionForTrack:track2 asset:assets[1]];
  
  mainInstruction.layerInstructions = @[firstInstruction, secondInstruction];
  AVMutableVideoComposition *mainComposition = [AVMutableVideoComposition new];
  mainComposition.instructions = @[mainInstruction];
  mainComposition.frameDuration = CMTimeMake(1, 30);
  mainComposition.renderSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
  
  NSString *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0];
  NSDateFormatter *df = [NSDateFormatter new];
  df.dateStyle = NSDateFormatterLongStyle;
  df.timeStyle = NSDateFormatterShortStyle;
  NSString *date = [df stringFromDate:[NSDate date]];
  NSString *savePath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"mergeVideo-%@.mov", date]];
  NSURL *url = [NSURL fileURLWithPath:savePath];
  
  AVAssetExportSession *exporter = [AVAssetExportSession exportSessionWithAsset:mixComposition presetName:AVAssetExportPresetHighestQuality];
  exporter.outputURL = url;
  exporter.outputFileType = AVFileTypeQuickTimeMovie;
  exporter.shouldOptimizeForNetworkUse = true;
  exporter.videoComposition = mainComposition;
  
  [exporter exportAsynchronouslyWithCompletionHandler:^{
    dispatch_async(dispatch_get_main_queue(), ^{
      [self exportDidFinish:exporter];
    });
  }];
}

- (void)exportDidFinish:(AVAssetExportSession *)session {
  if (session.status == AVAssetExportSessionStatusCompleted) {
    NSURL *outputURL = session.outputURL;
    self.mergedVideoURL = outputURL;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
      [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:outputURL];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
      if (success) {
        NSLog(@"Video saved");
        [UIAlertController showAlert:@"Видео сохранилось в вашей библиотеке" message:@"" inVC:self];
        [self.assets removeAllObjects];
      } else {
        NSLog(@"exportDidFinish = %@", error);
        [UIAlertController showAlert:@"Ошибка" message:@"Что то пошло не так" inVC:self];
      }
    }];
  }
}

- (AVMutableVideoCompositionLayerInstruction *)videoCompositionInstructionForTrack:(AVCompositionTrack *)track asset:(AVAsset *)asset {
  
  AVMutableVideoCompositionLayerInstruction *instruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:track];
  AVAssetTrack *assetTrack = [asset tracksWithMediaType:AVMediaTypeVideo][0];
  
  CGAffineTransform transform = [assetTrack preferredTransform];
  NSDictionary *assetInfo = [self orientationFromTransform:transform];
  
  double scaleToFitRatio = UIScreen.mainScreen.bounds.size.width / assetTrack.naturalSize.width;
  if ([assetInfo[@"isPortrait"] boolValue]) {
    scaleToFitRatio = UIScreen.mainScreen.bounds.size.width / assetTrack.naturalSize.height;
    CGAffineTransform scaleFactor = CGAffineTransformMakeScale(scaleToFitRatio, scaleToFitRatio);
    [instruction setTransform:CGAffineTransformConcat(assetTrack.preferredTransform, scaleFactor) atTime:kCMTimeZero];
  } else {
    CGAffineTransform scaleFactor = CGAffineTransformMakeScale(scaleToFitRatio, scaleToFitRatio);
    CGAffineTransform concat = CGAffineTransformConcat(CGAffineTransformConcat(assetTrack.preferredTransform, scaleFactor), CGAffineTransformMakeTranslation(0, UIScreen.mainScreen.bounds.size.width / 2));
    
    if ([assetInfo[@"assetOrientation"] integerValue] == UIImageOrientationDown) {
      CGAffineTransform fixUpsideDown = CGAffineTransformMakeRotation(M_PI);
      CGRect windowBounds = UIScreen.mainScreen.bounds;
      CGFloat yFix = assetTrack.naturalSize.height + windowBounds.size.height;
      CGAffineTransform centerFix = CGAffineTransformMakeTranslation(assetTrack.naturalSize.width, yFix);
      concat = CGAffineTransformConcat(CGAffineTransformConcat(fixUpsideDown, centerFix), scaleFactor);
    }
    [instruction setTransform:concat atTime:kCMTimeZero];
  }
  
  return instruction;
}

- (NSDictionary *)orientationFromTransform:(CGAffineTransform)transform {
  
  UIImageOrientation assetOrientation = UIImageOrientationUp;
  BOOL isPortrait = NO;
  
  if (transform.a == 0 && transform.b == 1.0 && transform.c == -1.0 && transform.d == 0) {
    assetOrientation = UIImageOrientationRight;
    isPortrait = true;
  } else if (transform.a == 0 && transform.b == -1.0 && transform.c == 1.0 && transform.d == 0) {
    assetOrientation = UIImageOrientationLeft;
    isPortrait = true;
  } else if (transform.a == 1.0 && transform.b == 0 && transform.c == 0 && transform.d == 1.0) {
    assetOrientation = UIImageOrientationUp;
  } else if (transform.a == -1.0 && transform.b == 0 && transform.c == 0 && transform.d == -1.0) {
    assetOrientation = UIImageOrientationDown;
  }
  
  return @{@"assetOrientation" : @(assetOrientation), @"isPortrait" : @(isPortrait)};
}

#pragma mark - SMRLoginViewControllerDelegate

- (void)SMRLoginDidFinishLogin {
  NSLog(@"USER LOGGED IN");
  [self updateUserInfo];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
  [self dismissViewControllerAnimated:YES completion:nil];
  
  NSString *mediaType = info[UIImagePickerControllerMediaType];
  if (mediaType == (NSString *)kUTTypeMovie) {
    
    switch (self.sourceType) {
      case SMRVideoSourceTypeCamera: {
        NSURL *mediaURL = info[UIImagePickerControllerMediaURL];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(mediaURL.path)) {
          UISaveVideoAtPathToSavedPhotosAlbum(mediaURL.path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
        AVPlayer *player = [AVPlayer playerWithURL:info[UIImagePickerControllerMediaURL]];
        [self updateViewsWithPlayer:player];
        [self.assets addObject:[AVAsset assetWithURL:info[UIImagePickerControllerMediaURL]]];
        break;
      }
        
      case SMRVideoSourceTypeSavedPhotosAlbum: {
        AVPlayer *player = [AVPlayer playerWithURL:info[UIImagePickerControllerMediaURL]];
        [self updateViewsWithPlayer:player];
        [self.assets addObject:[AVAsset assetWithURL:info[UIImagePickerControllerMediaURL]]];
        break;
      }
        
      default:
        break;
    }
  }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
