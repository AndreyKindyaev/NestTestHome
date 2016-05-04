//
//  SCNNestAuthManager.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/2/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCNNestAuthManager : NSObject

+ (instancetype)sharedInstance;

- (NSString *)webAuthUrl;
- (NSString *)validToken;

- (void)getTokenByAuthCode:(NSString *)authCode completion:(void(^)(NSError *error))completion;
- (BOOL)isRedirectUrl:(NSURL *)url;

@end