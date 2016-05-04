//
//  NSError+Utils.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "NSError+Utils.h"

NSString *const SCNErrorDomain = @"SCNErrorDomain";

@implementation NSError (Utils)

+ (NSError *)scnErrorWithCode:(SCNErrorCode)code {
    return [NSError errorWithDomain:SCNErrorDomain
                               code:code
                           userInfo:[self _userInfoForCode:code]];
}

#pragma mark - Private
+ (NSDictionary *)_userInfoForCode:(SCNErrorCode)code {
    NSDictionary *userInfo = nil;
    switch (code) {
        default:
            break;
    }
    return userInfo;
}

@end
