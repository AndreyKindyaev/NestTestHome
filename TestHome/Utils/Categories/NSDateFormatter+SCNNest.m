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
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [self new];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
    });
    return formatter;
}

// @"yyyy.MM.dd HH:mm"
+ (NSDateFormatter *)scnUIDateFormatter {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [self new];
        formatter.dateFormat = @"yyyy.MM.dd HH:mm";
    });
    return formatter;
}

@end
