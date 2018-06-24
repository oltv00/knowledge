//
//  APIManager.m
//  Test-centr-delovih-innovacii
//
//  Created by Oleg Tverdokhleb on 11/12/2016.
//  Copyright © 2016 oltv00. All rights reserved.
//

#import "APIManager.h"
#import "SMRAccessToken.h"
#import "SMRUser.h"
#import <AFNetworking/AFNetworking.h>

@interface APIManager() <NSURLSessionDelegate>
@property (strong, nonatomic) SMRAccessToken *accessToken;
@end

@implementation APIManager

+ (APIManager *)shared {
  static APIManager *manager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    manager = [[APIManager alloc] init];
  });
  return manager;
}

- (void)authUserWithLogin:(NSString *)login
                 password:(NSString *)password
               completion:(void(^)(APIManagerServerResponse status))completion
{
  
  NSLog(@"ACCESS TOKEN = %@", self.accessToken);
  
  NSString *stringURL = @"http://authorization.smiber.com:8000/oauth/token";
  NSString *post = [NSString stringWithFormat:@"grant_type=password&username=%@&password=%@", login, password];
  NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
  NSURL *url = [NSURL URLWithString:stringURL];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
  [request setHTTPMethod:@"POST"];
  [request setHTTPBody:postData];
  
  NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
  NSURLSession *session = [NSURLSession sessionWithConfiguration:conf delegate:self delegateQueue:nil];
  
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    // Status code response check
    switch (httpResponse.statusCode) {
      case 200: {
      
        NSError *jsonError = nil;
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        if (jsonError) {
          NSLog(@"jsonError = %@", jsonError);
        }
        NSLog(@"JSON = %@", json);
        if ([json isKindOfClass:[NSDictionary class]]) {
          NSDictionary *dictJSON = (NSDictionary *)json;
          
          // user && token save
          self.accessToken = [[SMRAccessToken alloc] initWithResponse:dictJSON];
          SMRUser *user = [[SMRUser alloc] initWithResponse:dictJSON];
          NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
          NSData *tokenData = [NSKeyedArchiver archivedDataWithRootObject:self.accessToken];
          [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"SMRUser"];
          [[NSUserDefaults standardUserDefaults] setObject:tokenData forKey:@"AccessToken"];
          [[NSUserDefaults standardUserDefaults] setObject:self.accessToken.expires_in forKey:@"expires_in"];
        }
        
        completion(APIManagerServerResponseSuccess);
        break;
      }
  
      case 401:
        completion(APIManagerServerResponseWrongPassword);
        break;
        
      default:
        completion(APIManagerServerResponseFailure);
        break;
    }
  }];
  
  [task resume];
  
}

- (void)uploadVideoWithName:(NSString *)name
                      video:(NSURL *)videoURL
                 compeltion:(void(^)(APIManagerServerResponse status))completion
{
  
  if (!self.accessToken) {
    NSData *tokenData = [[NSUserDefaults standardUserDefaults] objectForKey:@"AccessToken"];
    self.accessToken = [NSKeyedUnarchiver unarchiveObjectWithData:tokenData];
  }
  
  NSLog(@"ACCESS TOKEN = %@", self.accessToken.token);
  
  NSString *stringURL = @"http://api.smiber.com:8000/api/v1/content/add";
  NSString *authHeaderString = [NSString stringWithFormat:@"Bearer %@", self.accessToken.token];
  NSDictionary *params = @{
                           @"name" : name,
                           @"type_content" : @"VIDEO"
                           };
  
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  [manager.requestSerializer setValue:authHeaderString forHTTPHeaderField:@"Authorization"];
  
  [manager POST:stringURL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    NSError *formDataWriteError = nil;
    [formData appendPartWithFileURL:videoURL name:@"video" error:&formDataWriteError];
    if (formDataWriteError) {
      NSLog(@"formDataWriteError = %@", formDataWriteError);
    }
  } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"response = %@", responseObject);
    
    NSString *status = responseObject[@"status"];
    if ([status isEqualToString:@"SUCCESS"]) {
      completion(APIManagerServerResponseSuccess);
    } else if ([status isEqualToString:@"FAIL"]) {
      completion(APIManagerServerResponseFailure);
    }
    
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"error = %@", error);
  }];
}

@end
