//
//  NSError+Utils.h
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const SCNErrorDomain;

typedef NS_ENUM(NSInteger, SCNErrorCode) {
    SCNErrorCodeWrongDataFormat = 1,
    SCNErrorCodeInvalidObserver = 2,
};

@interface NSError (Utils)

+ (NSError *)scnErrorWithCode:(SCNErrorCode)code;

@end
