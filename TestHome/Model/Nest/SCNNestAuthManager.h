//
//  SCNNestAuthManager.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/2/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPSessionManager.h>

@interface SCNNestAuthManager : AFHTTPSessionManager

+ (instancetype)sharedInstance;

- (NSString *)webAuthUrl;
- (NSString *)validToken;

- (void)getTokenByAuthCode:(NSString *)authCode completion:(void(^)(NSError *error))completion;

@end
