//
//  SCNNilObjectValueTransformer+Presentation.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/11/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNilObjectValueTransformer+Presentation.h"

@implementation SCNNilObjectValueTransformer (Presentation)

+ (NSString *)nilDashesStringForValue:(id)value
                         forwardBlock:(MTLValueTransformerBlock)forwardBlock {
    return [self transformedValue:value
             usingForwardNilValue:@"--"
                     forwardBlock:forwardBlock];
}

+ (NSString *)nilDashesUIStringForDate:(NSDate *)date {
    return [self nilDashesStringForValue:date
                            forwardBlock:
            ^id(NSDate *value, BOOL *success, NSError *__autoreleasing *error) {
                return value.scnUIString;
            }];
}

+ (NSString *)nilDashesStringForBoolValue:(NSNumber *)boolNumber {
    return [self nilDashesStringForValue:boolNumber
                            forwardBlock:
            ^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
                return value.boolValue ? @"Yes" : @"No";
            }];
}

@end
