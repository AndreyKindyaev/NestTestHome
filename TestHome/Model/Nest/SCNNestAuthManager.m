//
//  SCNNestAuthManager.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/2/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestAuthManager.h"

#import "SCNNestAuthToken.h"

static NSString *const kNestAPIDomain = @"home.nest.com";
static NSString *const kNestClientId = @"7c046662-65fe-4884-905f-23d209710343";
static NSString *const kNestClientSecret = @"0edw2mQARii1BQfw7zmG84wsz";
static NSString *const kNestState = @"NestState";

static NSString *const kAccessTokenKey = @"AccessTokenKey";

@implementation SCNNestAuthManager

+ (instancetype)sharedInstance {
    static SCNNestAuthManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:kNestAPIDomain]];
        sharedInstance.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    return sharedInstance;
}

- (NSString *)webAuthUrl {
    return [NSString stringWithFormat:@"http://%@/login/oauth2?client_id=%@&state=%@", kNestAPIDomain, kNestClientId, kNestState];
}

- (NSString *)validToken {
    SCNNestAuthToken *localAuthToken = [self _localAuthToken];
    return [localAuthToken isValid] ? localAuthToken.string : nil;
}

- (void)getTokenByAuthCode:(NSString *)authCode completion:(void(^)(NSError *error))completion {
    void(^safeCompletion)(NSError *) = ^(NSError *error) {
        if (nil != completion) {
            completion(error);
        }
    };
    NSString *urlString = [self _accessTokenUrlStringWithAuthCode:authCode];
    [self POST:urlString parameters:nil constructingBodyWithBlock:nil progress:nil success:
     ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         safeCompletion(nil);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         safeCompletion(error);
     }];
}

#pragma mark - Private
- (NSString *)_accessTokenUrlStringWithAuthCode:(NSString *)authCode {
    return [NSString stringWithFormat:@"http://api.%@/oauth2/access_token?code=%@&client_id=%@&client_secret=%@&grant_type=authorization_code", kNestAPIDomain, authCode, kNestClientId, kNestClientSecret];
}

- (SCNNestAuthToken *)_localAuthToken {
    SCNNestAuthToken *localAuthToken = nil;
    NSData *encodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:kAccessTokenKey];
    if (nil != encodedObject) {
        localAuthToken = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    }
    return localAuthToken;
}

@end
