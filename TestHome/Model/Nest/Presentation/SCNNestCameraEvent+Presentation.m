//
//  SCNNestCameraEvent+Presentation.m
//  TestHome
//
//  Created by Andrey Kindyaev on 5/11/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "SCNNestCameraEvent+Presentation.h"

@implementation SCNNestCameraEvent (Presentation)

- (NSString *)hasSoundString {
    return [SCNNilObjectValueTransformer nilDashesStringForBoolValue:self.hasSoundNumber];
}

- (NSString *)hasMotionString {
    return [SCNNilObjectValueTransformer nilDashesStringForBoolValue:self.hasMotionNumber];
}

- (NSString *)startTimeString {
    return [SCNNilObjectValueTransformer nilDashesUIStringForDate:self.startTime];
}

- (NSString *)endTimeString {
    return [SCNNilObjectValueTransformer nilDashesUIStringForDate:self.endTime];
}

- (NSString *)urlsExpireTimeString {
    return [SCNNilObjectValueTransformer nilDashesUIStringForDate:self.urlsExpireTime];
}

- (BOOL)isUrlsExpired {
    return ([[NSDate date] compare:self.urlsExpireTime] != NSOrderedAscending);
}

@end
