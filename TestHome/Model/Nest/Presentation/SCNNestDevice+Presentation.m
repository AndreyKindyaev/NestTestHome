//
//  SCNNestDevice+Presentation.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/5/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestDevice+Presentation.h"

@implementation SCNNestDevice (Presentation)

- (NSString *)isOnlineString {
    return [SCNNilObjectValueTransformer transformedValue:self.isOnlineNumber
                                     usingForwardNilValue:@"--"
                                             forwardBlock:
            ^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
                return value.boolValue ? @"Online" : @"Offline";
            }];
}

- (UIColor *)isOnlineTextColor {
    return [SCNNilObjectValueTransformer transformedValue:self.isOnlineNumber
                                     usingForwardNilValue:[UIColor grayColor]
                                             forwardBlock:
            ^id(NSNumber *value, BOOL *success, NSError *__autoreleasing *error) {
                return value.boolValue ? [UIColor greenColor] : [UIColor redColor];
            }];
}

@end
