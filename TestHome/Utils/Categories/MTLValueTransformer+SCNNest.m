//
//  MTLValueTransformer+SCNNest.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/4/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "MTLValueTransformer+SCNNest.h"

#import "NSDateFormatter+SCNNest.h"

@implementation MTLValueTransformer (SCNNest)

+ (MTLValueTransformer *)scnNestJSONDateTransformer {
    NSDateFormatter *formatter = [NSDateFormatter scnNestDateFormatter];
    return [self transformerUsingForwardBlock:
            ^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
                return [formatter dateFromString:dateString];
            } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
                return [formatter stringFromDate:date];
            }];
}

@end
