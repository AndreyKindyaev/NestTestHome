//
//  NSDateFormatter+SCNNest.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "NSDateFormatter+SCNNest.h"

@implementation NSDateFormatter (SCNNest)

+ (NSDateFormatter *)scnNestDateFormatter {
    static NSDateFormatter *serverDateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serverDateFormatter = [self new];
        serverDateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
    });
    return serverDateFormatter;
}

@end
