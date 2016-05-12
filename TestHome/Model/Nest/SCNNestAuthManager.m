//
//  SCNNestAuthManager.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/2/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestAuthManager.h"

#import <AFHTTPSessionManager.h>
#import "SCNNestAuthToken.h"

static NSString *const kNestAPIDomain = @"home.nest.com";
static NSString *const kNestClientId = @"7c046662-65fe-4884-905f-23d209710343";
static NSString *const kNestClientSecret = @"0edw2mQARii1BQfw7zmG84wsz";
static NSString *const kNestState = @"NestState";
static NSString *const kRedirectUrlString = @"https://scnsoft.com/TestHome";

static NSString *const kAccessTokenKey = @"AccessTokenKey";

@interface SCNNestAuthManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation SCNNestAuthManager

+ (instancetype)sharedInstance {
    static SCNNestAuthManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (nil != self) {
        AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kNestAPIDomain]];
        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.sessionManager = sessionManager;
    }
    return self;
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
    __weak typeof(self) weakSelf = self;
    [self.sessionManager POST:urlString parameters:nil constructingBodyWithBlock:nil progress:nil success:
     ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSError *error = nil;
         SCNNestAuthToken *token = [MTLJSONAdapter modelOfClass:[SCNNestAuthToken class]
                                             fromJSONDictionary:responseObject
                                                          error:&error];
         if (nil == error) {
             [weakSelf _setLocalAuthToken:token];
         }
         safeCompletion(error);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         safeCompletion(error);
     }];
}

- (BOOL)isRedirectUrl:(NSURL *)url {
    NSURL *redirectUrl = [NSURL URLWithString:kRedirectUrlString];
    return [[url host] isEqualToString:[redirectUrl host]];
}

- (void)logout {
    [self _setLocalAuthToken:nil];
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [storage cookies];
    for (NSHTTPCookie *cookie in cookies) {
        [storage deleteCookie:cookie];
    }
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

- (void)_setLocalAuthToken:(SCNNestAuthToken *)token {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (nil != token) {
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:token];
        [standardUserDefaults setObject:encodedObject forKey:kAccessTokenKey];
    } else {
        [standardUserDefaults removeObjectForKey:kAccessTokenKey];
    }
    [standardUserDefaults synchronize];
}

@end
